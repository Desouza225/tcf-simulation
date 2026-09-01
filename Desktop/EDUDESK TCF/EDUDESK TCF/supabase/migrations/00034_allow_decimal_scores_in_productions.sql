-- ==============================================================================
-- Migration 00034: Support des notes décimales (avec virgule/points ex: 13.5 / 13,4)
-- dans les productions et la fonction `submit_professeur_correction`
-- ==============================================================================

-- 1. Adapter la colonne `score` de la table `productions` en NUMERIC(5,2)
ALTER TABLE public.productions
  ALTER COLUMN score TYPE numeric(5,2);

-- 2. Supprimer les anciennes signatures de `submit_professeur_correction`
DROP FUNCTION IF EXISTS public.submit_professeur_correction(uuid, integer, jsonb, text, text, text);
DROP FUNCTION IF EXISTS public.submit_professeur_correction(uuid, numeric, jsonb, text, text, text);

-- 3. Recréer `submit_professeur_correction` avec `p_score numeric`
CREATE OR REPLACE FUNCTION public.submit_professeur_correction(
  p_production_id uuid,
  p_score numeric,
  p_grille_notation jsonb DEFAULT NULL,
  p_commentaire text DEFAULT NULL,
  p_raison_refus text DEFAULT NULL,
  p_statut text DEFAULT 'corrige'
)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_caller_id         uuid;
  v_caller_role       text;
  v_prod              record;
  v_session_id        uuid;
  v_etudiant_id       uuid;
  v_epreuve           text;
  v_numero_tache      integer;
  v_epreuve_label     text;
  v_prods_ee_count    integer := 0;
  v_prods_ee_done     integer := 0;
  v_prods_ee_sum      numeric := 0;
  v_prods_eo_count    integer := 0;
  v_prods_eo_done     integer := 0;
  v_prods_eo_sum      numeric := 0;
  v_sess              record;
  v_score_ee_final    integer;
  v_score_eo_final    integer;
  v_scores_arr        integer[];
  v_score_global      integer;
  v_niveau_cecrl      text;
  v_max_ee            numeric := 20;
  v_max_eo            numeric := 18;
BEGIN
  v_caller_id := auth.uid();
  IF v_caller_id IS NULL THEN
    RAISE EXCEPTION 'Non authentifié. Veuillez vous reconnecter.';
  END IF;

  -- S'assurer que le profil professeur existe dans public.profiles
  INSERT INTO public.profiles (id, email, role, created_at, updated_at)
  SELECT u.id, u.email, 'professeur', now(), now()
  FROM auth.users u
  WHERE u.id = v_caller_id
  ON CONFLICT (id) DO NOTHING;

  -- Vérifier le rôle de l'appelant
  SELECT role::text INTO v_caller_role FROM public.profiles WHERE id = v_caller_id;
  IF v_caller_role IS NULL OR lower(trim(v_caller_role)) NOT IN ('professeur', 'admin', 'super_admin', 'enseignant') THEN
    IF NOT EXISTS (
      SELECT 1 FROM auth.users u
      WHERE u.id = v_caller_id
        AND (
          u.raw_user_meta_data->>'role' IN ('professeur', 'admin', 'super_admin', 'enseignant')
          OR u.raw_app_meta_data->>'role' IN ('professeur', 'admin', 'super_admin', 'enseignant')
        )
    ) THEN
      RAISE EXCEPTION 'Accès refusé : rôle professeur ou administrateur requis.';
    END IF;
  END IF;

  -- Récupérer la production
  SELECT id, session_id, etudiant_id, epreuve, numero_tache, audio_url
  INTO v_prod
  FROM public.productions
  WHERE id = p_production_id;

  IF v_prod.id IS NULL THEN
    RAISE EXCEPTION 'Production introuvable (ID : %)', p_production_id;
  END IF;

  v_session_id   := v_prod.session_id;
  v_etudiant_id  := v_prod.etudiant_id;
  v_epreuve      := v_prod.epreuve;
  v_numero_tache := v_prod.numero_tache;

  -- Mettre à jour la production avec la note décimale
  IF p_statut = 'refuse' THEN
    UPDATE public.productions
    SET
      statut_correction = 'refuse',
      score = 0,
      audio_url = NULL,
      contenu_texte = NULL,
      raison_refus = p_raison_refus,
      grille_notation = p_grille_notation,
      commentaire = p_commentaire,
      corrige_at = now(),
      professeur_id = v_caller_id
    WHERE id = p_production_id;
  ELSE
    UPDATE public.productions
    SET
      statut_correction = 'corrige',
      score = p_score,
      commentaire = p_commentaire,
      grille_notation = p_grille_notation,
      raison_refus = NULL,
      corrige_at = now(),
      professeur_id = v_caller_id
    WHERE id = p_production_id;
  END IF;

  -- Recalculer la session parente si existante
  IF v_session_id IS NOT NULL THEN
    BEGIN
      SELECT
        count(*),
        count(*) FILTER (WHERE statut_correction IN ('corrige', 'refuse')),
        coalesce(sum(score), 0)
      INTO v_prods_ee_count, v_prods_ee_done, v_prods_ee_sum
      FROM public.productions
      WHERE session_id = v_session_id AND epreuve = 'expression_ecrite';

      SELECT
        count(*),
        count(*) FILTER (WHERE statut_correction IN ('corrige', 'refuse')),
        coalesce(sum(score), 0)
      INTO v_prods_eo_count, v_prods_eo_done, v_prods_eo_sum
      FROM public.productions
      WHERE session_id = v_session_id AND epreuve = 'expression_orale';

      SELECT id, mode, score_oral, score_ecrit, score_expression_ecrite, score_expression_orale
      INTO v_sess
      FROM public.sessions_examen
      WHERE id = v_session_id;

      IF v_sess.id IS NOT NULL THEN
        IF v_prods_ee_count > 0 AND v_prods_ee_count = v_prods_ee_done THEN
          v_score_ee_final := round((v_prods_ee_sum / (v_max_ee * v_prods_ee_count)) * 699);
        ELSE
          v_score_ee_final := v_sess.score_expression_ecrite;
        END IF;

        IF v_prods_eo_count > 0 AND v_prods_eo_count = v_prods_eo_done THEN
          v_score_eo_final := round((v_prods_eo_sum / (v_max_eo * v_prods_eo_count)) * 699);
        ELSE
          v_score_eo_final := v_sess.score_expression_orale;
        END IF;

        IF (v_prods_ee_count = 0 OR v_prods_ee_count = v_prods_ee_done)
           AND (v_prods_eo_count = 0 OR v_prods_eo_count = v_prods_eo_done)
           AND (v_prods_ee_count > 0 OR v_prods_eo_count > 0) THEN

          v_scores_arr := ARRAY[]::integer[];
          IF v_sess.score_oral IS NOT NULL THEN v_scores_arr := array_append(v_scores_arr, v_sess.score_oral); END IF;
          IF v_sess.score_ecrit IS NOT NULL THEN v_scores_arr := array_append(v_scores_arr, v_sess.score_ecrit); END IF;
          IF v_score_ee_final IS NOT NULL THEN v_scores_arr := array_append(v_scores_arr, v_score_ee_final); END IF;
          IF v_score_eo_final IS NOT NULL THEN v_scores_arr := array_append(v_scores_arr, v_score_eo_final); END IF;

          IF array_length(v_scores_arr, 1) IS NOT NULL AND array_length(v_scores_arr, 1) > 0 THEN
            SELECT round(avg(val)) INTO v_score_global FROM unnest(v_scores_arr) AS val;

            IF v_score_global >= 549 THEN v_niveau_cecrl := 'C2';
            ELSIF v_score_global >= 499 THEN v_niveau_cecrl := 'C1';
            ELSIF v_score_global >= 406 THEN v_niveau_cecrl := 'B2';
            ELSIF v_score_global >= 301 THEN v_niveau_cecrl := 'B1';
            ELSIF v_score_global >= 226 THEN v_niveau_cecrl := 'A2';
            ELSE v_niveau_cecrl := 'A1';
            END IF;
          END IF;

          UPDATE public.sessions_examen
          SET
            score_expression_ecrite = v_score_ee_final,
            score_expression_orale  = v_score_eo_final,
            score_global            = coalesce(v_score_global, score_global),
            niveau_cecrl            = CASE WHEN v_niveau_cecrl IS NOT NULL THEN v_niveau_cecrl::public.niveau_cecrl ELSE niveau_cecrl END,
            correction_complete     = true
          WHERE id = v_session_id;
        ELSE
          UPDATE public.sessions_examen
          SET
            score_expression_ecrite = v_score_ee_final,
            score_expression_orale  = v_score_eo_final
          WHERE id = v_session_id;
        END IF;
      END IF;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
  END IF;

  -- Notifier l'étudiant
  IF v_etudiant_id IS NOT NULL THEN
    BEGIN
      v_epreuve_label := CASE WHEN v_epreuve = 'expression_ecrite' THEN 'Expression écrite' ELSE 'Expression orale' END;

      IF p_statut = 'refuse' THEN
        INSERT INTO public.notifications (utilisateur_id, titre, message, lien)
        VALUES (
          v_etudiant_id,
          'Production refusée — Note 0',
          CASE WHEN p_raison_refus IS NOT NULL AND length(trim(p_raison_refus)) > 0
               THEN 'Votre ' || v_epreuve_label || ' — Tâche ' || v_numero_tache || ' a été refusée (note : 0/20). Motif : ' || trim(p_raison_refus)
               ELSE 'Votre ' || v_epreuve_label || ' — Tâche ' || v_numero_tache || ' a été refusée par votre professeur. Note attribuée : 0/20.'
          END,
          '/etudiant/historique'
        );
      ELSE
        INSERT INTO public.notifications (utilisateur_id, titre, message, lien)
        VALUES (
          v_etudiant_id,
          'Correction disponible',
          'Votre ' || v_epreuve_label || ' — Tâche ' || v_numero_tache || ' a été corrigée (' || p_score || ' pts).',
          '/etudiant/historique'
        );
      END IF;
    EXCEPTION WHEN OTHERS THEN
      NULL;
    END;
  END IF;

  RETURN jsonb_build_object(
    'success', true,
    'production_id', p_production_id,
    'session_id', v_session_id,
    'score', p_score,
    'statut', p_statut
  );
END;
$$;

GRANT EXECUTE ON FUNCTION public.submit_professeur_correction(uuid, numeric, jsonb, text, text, text) TO authenticated;
