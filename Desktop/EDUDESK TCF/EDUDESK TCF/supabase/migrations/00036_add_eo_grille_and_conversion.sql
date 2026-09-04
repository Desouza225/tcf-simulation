-- ==============================================================================
-- Migration 00036: Grille d'évaluation officielle Expression Orale TCF Canada (20 pts)
-- et table de conversion CECRL correspondante
-- ==============================================================================

-- 1. Insertion de la grille officielle Expression Orale TCF Canada (3 dimensions, 20 points)
INSERT INTO public.grilles_evaluation (id, epreuve, total_points, mode_notation, grille_structure, conversion_cecrl)
VALUES (
  'expression_orale_tcf',
  'expression_orale',
  20,
  'manuel_professeur',
  '{
    "dimensions": [
      {
        "nom": "Critères linguistiques",
        "points_max": 8,
        "criteres": [
          { "nom": "Étendue et maîtrise du lexique", "points_max": 2, "description": "Vocabulaire varié et précis. Capacité à utiliser des expressions idiomatiques et à contourner les mots inconnus." },
          { "nom": "Correction grammaticale", "points_max": 2, "description": "Conjugaison correcte, accords (sujet-verbe, nom-adjectif), structures de phrases variées (simples, complexes, subordonnées)." },
          { "nom": "Aisance et fluidité", "points_max": 2, "description": "Débit naturel, peu d''hésitations (« euh… », silences longs), capacité à parler en continu sans bloquer." },
          { "nom": "Prononciation et intonation", "points_max": 2, "description": "Articulation claire, prononciation correcte des sons français (nasales, u/ou, é/è), intonation naturelle." }
        ]
      },
      {
        "nom": "Critères pragmatiques",
        "points_max": 8,
        "criteres": [
          { "nom": "Capacité à interagir", "points_max": 2, "description": "Saluer, poser des questions adaptées, relancer, prendre son tour de parole, répondre aux questions de l''examinateur." },
          { "nom": "Structuration du discours", "points_max": 3, "description": "Organisation logique (introduction, développement, conclusion). Utilisation de connecteurs oraux (d''abord, ensuite, cependant, donc, en résumé)." },
          { "nom": "Cohérence et développement thématique", "points_max": 3, "description": "Les idées s''enchaînent logiquement. Le sujet est développé avec des exemples, des arguments ou des explications. Pas de hors-sujet." }
        ]
      },
      {
        "nom": "Critères sociolinguistiques",
        "points_max": 4,
        "criteres": [
          { "nom": "Adéquation à la situation de communication", "points_max": 4, "description": "Le ton, le style et le registre correspondent à la tâche (entretien formel T1, jeu de rôle quotidien T2, présentation argumentée T3). Formules de politesse adaptées." }
        ]
      }
    ]
  }'::jsonb,
  '[
    { "score_min": 0, "score_max": 0, "niveau_cecrl": "A1 non atteint" },
    { "score_min": 1, "score_max": 1, "niveau_cecrl": "A1" },
    { "score_min": 2, "score_max": 5, "niveau_cecrl": "A2" },
    { "score_min": 6, "score_max": 9, "niveau_cecrl": "B1" },
    { "score_min": 10, "score_max": 13, "niveau_cecrl": "B2" },
    { "score_min": 14, "score_max": 17, "niveau_cecrl": "C1" },
    { "score_min": 18, "score_max": 20, "niveau_cecrl": "C2" }
  ]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  grille_structure = EXCLUDED.grille_structure,
  conversion_cecrl = EXCLUDED.conversion_cecrl,
  updated_at = now();

-- 2. Fonction SQL de conversion Expression Orale (Score /20 -> Code CECRL)
CREATE OR REPLACE FUNCTION public.convert_score_eo_to_cecrl(p_score numeric)
RETURNS text
LANGUAGE sql
IMMUTABLE
AS $$
  SELECT CASE
    WHEN p_score >= 18 THEN 'C2'
    WHEN p_score >= 14 THEN 'C1'
    WHEN p_score >= 10 THEN 'B2'
    WHEN p_score >= 6  THEN 'B1'
    WHEN p_score >= 2  THEN 'A2'
    ELSE 'A1'
  END;
$$;

-- 3. Fonction SQL de conversion Expression Orale (Score /20 -> Label CECRL)
CREATE OR REPLACE FUNCTION public.convert_score_eo_to_cecrl_label(p_score numeric)
RETURNS text
LANGUAGE sql
IMMUTABLE
AS $$
  SELECT CASE
    WHEN p_score >= 18 THEN 'C2'
    WHEN p_score >= 14 THEN 'C1'
    WHEN p_score >= 10 THEN 'B2'
    WHEN p_score >= 6  THEN 'B1'
    WHEN p_score >= 2  THEN 'A2'
    WHEN p_score >= 1  THEN 'A1'
    ELSE 'A1 non atteint'
  END;
$$;

-- 4. Mise à jour de la RPC `submit_professeur_correction` avec MAX_EO = 20
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
  v_max_eo            numeric := 20;
BEGIN
  v_caller_id := auth.uid();
  IF v_caller_id IS NULL THEN
    RAISE EXCEPTION 'Non authentifié. Veuillez vous reconnecter.';
  END IF;

  INSERT INTO public.profiles (id, email, role, created_at, updated_at)
  SELECT u.id, u.email, 'professeur', now(), now()
  FROM auth.users u
  WHERE u.id = v_caller_id
  ON CONFLICT (id) DO NOTHING;

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

  IF p_statut = 'refuse' THEN
    UPDATE public.productions
    SET
      statut_correction = 'refuse',
      score = 0,
      audio_url = NULL,
      contenu_texte = NULL,
      raison_refus = coalesce(trim(p_raison_refus), 'Production refusée par l''enseignant.'),
      commentaire = NULL,
      grille_notation = coalesce(p_grille_notation, grille_notation),
      corrige_at = now(),
      professeur_id = v_caller_id,
      updated_at = now()
    WHERE id = p_production_id;
  ELSE
    UPDATE public.productions
    SET
      statut_correction = 'corrige',
      score = p_score,
      commentaire = coalesce(p_commentaire, commentaire),
      grille_notation = coalesce(p_grille_notation, grille_notation),
      raison_refus = NULL,
      corrige_at = now(),
      professeur_id = v_caller_id,
      updated_at = now()
    WHERE id = p_production_id;
  END IF;

  -- Synchroniser la session
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
          'Votre ' || v_epreuve_label || ' — Tâche ' || v_numero_tache || ' a été évaluée (' || p_score || '/20 pts).',
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
    'score', CASE WHEN p_statut = 'refuse' THEN 0 ELSE p_score END,
    'statut', p_statut
  );
END;
$$;
