-- Migration 00033: Correction RLS Professeurs, RPC de soumission atomique et Tâche 2 Expression Orale

-- ─── 1. Fonction Helper de rôle (SECURITY DEFINER STABLE) ──────────────────────
CREATE OR REPLACE FUNCTION public.is_professeur_or_admin(uid uuid)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
SET search_path = public
AS $$
  SELECT EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = uid AND role IN ('professeur', 'admin', 'super_admin')
  );
$$;

GRANT EXECUTE ON FUNCTION public.is_professeur_or_admin(uuid) TO authenticated;

-- ─── 2. Politiques RLS sur `productions` ───────────────────────────────────────
-- Permettre à tout professeur / admin de voir et corriger toutes les productions (attribuées ou libres)
DROP POLICY IF EXISTS "Professeur can view and correct attributed student productions" ON public.productions;
DROP POLICY IF EXISTS "Professeur can view and update attributed student productions" ON public.productions;
DROP POLICY IF EXISTS "Professeur and admin can manage productions" ON public.productions;
DROP POLICY IF EXISTS "Student can manage own productions" ON public.productions;
DROP POLICY IF EXISTS "Admin can view all productions" ON public.productions;

CREATE POLICY "Student can manage own productions"
  ON public.productions
  FOR ALL
  TO authenticated
  USING (etudiant_id = auth.uid())
  WITH CHECK (etudiant_id = auth.uid());

CREATE POLICY "Professeur and admin can manage productions"
  ON public.productions
  FOR ALL
  TO authenticated
  USING (
    professeur_id = auth.uid()
    OR public.is_professeur_or_admin(auth.uid())
    OR EXISTS (
      SELECT 1 FROM public.attributions a
      WHERE a.etudiant_id = productions.etudiant_id
        AND a.professeur_id = auth.uid()
    )
  )
  WITH CHECK (
    professeur_id = auth.uid()
    OR public.is_professeur_or_admin(auth.uid())
    OR EXISTS (
      SELECT 1 FROM public.attributions a
      WHERE a.etudiant_id = productions.etudiant_id
        AND a.professeur_id = auth.uid()
    )
  );

-- ─── 3. Politiques RLS sur `sessions_examen` ───────────────────────────────────
-- Autoriser les professeurs et admins à mettre à jour les scores de session
DROP POLICY IF EXISTS "Professeur peut mettre a jour les sessions de ses etudiants" ON public.sessions_examen;
DROP POLICY IF EXISTS "Professeur et admin peuvent mettre a jour les sessions" ON public.sessions_examen;
DROP POLICY IF EXISTS "Professeur can view sessions of attributed students" ON public.sessions_examen;
DROP POLICY IF EXISTS "Professeur and admin can view sessions" ON public.sessions_examen;

CREATE POLICY "Professeur and admin can view sessions"
  ON public.sessions_examen
  FOR SELECT
  TO authenticated
  USING (
    etudiant_id = auth.uid()
    OR public.is_professeur_or_admin(auth.uid())
    OR EXISTS (
      SELECT 1 FROM public.attributions a
      WHERE a.professeur_id = auth.uid() AND a.etudiant_id = sessions_examen.etudiant_id
    )
  );

CREATE POLICY "Professeur et admin peuvent mettre a jour les sessions"
  ON public.sessions_examen
  FOR UPDATE
  TO authenticated
  USING (
    etudiant_id = auth.uid()
    OR public.is_professeur_or_admin(auth.uid())
    OR EXISTS (
      SELECT 1 FROM public.attributions a
      WHERE a.etudiant_id = sessions_examen.etudiant_id
        AND a.professeur_id = auth.uid()
    )
  )
  WITH CHECK (
    etudiant_id = auth.uid()
    OR public.is_professeur_or_admin(auth.uid())
    OR EXISTS (
      SELECT 1 FROM public.attributions a
      WHERE a.etudiant_id = sessions_examen.etudiant_id
        AND a.professeur_id = auth.uid()
    )
  );

-- ─── 4. Politiques RLS sur `notifications` ─────────────────────────────────────
DROP POLICY IF EXISTS "Professeur can insert notifications for students" ON public.notifications;

CREATE POLICY "Professeur can insert notifications for students"
  ON public.notifications
  FOR INSERT
  TO authenticated
  WITH CHECK (
    public.is_professeur_or_admin(auth.uid())
    OR EXISTS (
      SELECT 1 FROM public.attributions a
      WHERE a.etudiant_id = notifications.utilisateur_id
        AND a.professeur_id = auth.uid()
    )
  );

-- ─── 5. RPC Fonction `submit_professeur_correction` ────────────────────────────
-- Exécute la mise à jour de la production, le recalcul atomique de la session et la notification
CREATE OR REPLACE FUNCTION public.submit_professeur_correction(
  p_production_id uuid,
  p_score integer,
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
  v_all_prods         record;
  v_prods_ee_count    integer := 0;
  v_prods_ee_done     integer := 0;
  v_prods_ee_sum      integer := 0;
  v_prods_eo_count    integer := 0;
  v_prods_eo_done     integer := 0;
  v_prods_eo_sum      integer := 0;
  v_sess              record;
  v_score_ee_final    integer;
  v_score_eo_final    integer;
  v_scores_arr        integer[];
  v_score_global      integer;
  v_niveau_cecrl      public.niveau_cecrl;
  v_max_ee            integer := 20;
  v_max_eo            integer := 18;
BEGIN
  v_caller_id := auth.uid();
  IF v_caller_id IS NULL THEN
    RAISE EXCEPTION 'Non authentifié.';
  END IF;

  -- Vérifier le rôle de l'appelant
  SELECT role INTO v_caller_role FROM public.profiles WHERE id = v_caller_id;
  IF v_caller_role IS NULL OR v_caller_role NOT IN ('professeur', 'admin', 'super_admin') THEN
    RAISE EXCEPTION 'Accès refusé : rôle professeur ou administrateur requis.';
  END IF;

  -- Récupérer la production
  SELECT id, session_id, etudiant_id, epreuve, numero_tache, audio_url
  INTO v_prod
  FROM public.productions
  WHERE id = p_production_id;

  IF v_prod.id IS NULL THEN
    RAISE EXCEPTION 'Production introuvable.';
  END IF;

  v_session_id   := v_prod.session_id;
  v_etudiant_id  := v_prod.etudiant_id;
  v_epreuve      := v_prod.epreuve;
  v_numero_tache := v_prod.numero_tache;

  -- 1. Mettre à jour la production
  IF p_statut = 'refuse' THEN
    UPDATE public.productions
    SET
      statut_correction = 'refuse'::public.statut_correction,
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
      statut_correction = 'corrige'::public.statut_correction,
      score = p_score,
      commentaire = p_commentaire,
      grille_notation = p_grille_notation,
      raison_refus = NULL,
      corrige_at = now(),
      professeur_id = v_caller_id
    WHERE id = p_production_id;
  END IF;

  -- 2. Recalculer la session si rattachée à une session
  IF v_session_id IS NOT NULL THEN
    -- Calculer les totaux pour EE
    SELECT
      count(*),
      count(*) FILTER (WHERE statut_correction IN ('corrige', 'refuse')),
      coalesce(sum(score), 0)
    INTO v_prods_ee_count, v_prods_ee_done, v_prods_ee_sum
    FROM public.productions
    WHERE session_id = v_session_id AND epreuve = 'expression_ecrite';

    -- Calculer les totaux pour EO
    SELECT
      count(*),
      count(*) FILTER (WHERE statut_correction IN ('corrige', 'refuse')),
      coalesce(sum(score), 0)
    INTO v_prods_eo_count, v_prods_eo_done, v_prods_eo_sum
    FROM public.productions
    WHERE session_id = v_session_id AND epreuve = 'expression_orale';

    -- Récupérer la session actuelle
    SELECT id, mode, score_oral, score_ecrit, score_expression_ecrite, score_expression_orale
    INTO v_sess
    FROM public.sessions_examen
    WHERE id = v_session_id;

    IF v_sess.id IS NOT NULL THEN
      -- Calcul score EE
      IF v_prods_ee_count > 0 AND v_prods_ee_count = v_prods_ee_done THEN
        v_score_ee_final := round((v_prods_ee_sum::numeric / (v_max_ee * v_prods_ee_count)) * 699);
      ELSE
        v_score_ee_final := v_sess.score_expression_ecrite;
      END IF;

      -- Calcul score EO
      IF v_prods_eo_count > 0 AND v_prods_eo_count = v_prods_eo_done THEN
        v_score_eo_final := round((v_prods_eo_sum::numeric / (v_max_eo * v_prods_eo_count)) * 699);
      ELSE
        v_score_eo_final := v_sess.score_expression_orale;
      END IF;

      -- Vérifier si toutes les productions d'expression sont terminées
      IF (v_prods_ee_count = 0 OR v_prods_ee_count = v_prods_ee_done)
         AND (v_prods_eo_count = 0 OR v_prods_eo_count = v_prods_eo_done)
         AND (v_prods_ee_count > 0 OR v_prods_eo_count > 0) THEN

        v_scores_arr := ARRAY[]::integer[];
        IF v_sess.score_oral IS NOT NULL THEN v_scores_arr := array_append(v_scores_arr, v_sess.score_oral); END IF;
        IF v_sess.score_ecrit IS NOT NULL THEN v_scores_arr := array_append(v_scores_arr, v_sess.score_ecrit); END IF;
        IF v_score_ee_final IS NOT NULL THEN v_scores_arr := array_append(v_scores_arr, v_score_ee_final); END IF;
        IF v_score_eo_final IS NOT NULL THEN v_scores_arr := array_append(v_scores_arr, v_score_eo_final); END IF;

        IF array_length(v_scores_arr, 1) > 0 THEN
          SELECT round(avg(val)) INTO v_score_global FROM unnest(v_scores_arr) AS val;

          -- Déterminer le niveau CECRL
          IF v_score_global >= 549 THEN v_niveau_cecrl := 'C2'::public.niveau_cecrl;
          ELSIF v_score_global >= 499 THEN v_niveau_cecrl := 'C1'::public.niveau_cecrl;
          ELSIF v_score_global >= 406 THEN v_niveau_cecrl := 'B2'::public.niveau_cecrl;
          ELSIF v_score_global >= 301 THEN v_niveau_cecrl := 'B1'::public.niveau_cecrl;
          ELSIF v_score_global >= 226 THEN v_niveau_cecrl := 'A2'::public.niveau_cecrl;
          ELSE v_niveau_cecrl := 'A1'::public.niveau_cecrl;
          END IF;
        END IF;

        -- Mise à jour session complète
        UPDATE public.sessions_examen
        SET
          score_expression_ecrite = v_score_ee_final,
          score_expression_orale  = v_score_eo_final,
          score_global            = coalesce(v_score_global, score_global),
          niveau_cecrl            = coalesce(v_niveau_cecrl, niveau_cecrl),
          correction_complete     = true
        WHERE id = v_session_id;
      ELSE
        -- Mise à jour partielle session
        UPDATE public.sessions_examen
        SET
          score_expression_ecrite = v_score_ee_final,
          score_expression_orale  = v_score_eo_final
        WHERE id = v_session_id;
      END IF;
    END IF;
  END IF;

  -- 3. Notifier l'étudiant
  IF v_etudiant_id IS NOT NULL THEN
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

GRANT EXECUTE ON FUNCTION public.submit_professeur_correction(uuid, integer, jsonb, text, text, text) TO authenticated;

-- ─── 6. Synchronisation de la Tâche 2 Expression Orale dans `taches` ─────────────
-- Copie les sujets Tâche 2 de la table `questions` vers la table `taches` s'ils manquent
INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif)
SELECT
  'expression_orale'::public.epreuve_type,
  2,
  q.reference,
  q.texte,
  330, -- 2 min préparation + 3 min 30 échange
  true
FROM public.questions q
WHERE q.epreuve = 'expression_orale'
  AND (q.tache = 'tache_2' OR q.ordre = 2 OR q.reference LIKE 'EO_T2_%')
  AND q.texte IS NOT NULL
  AND NOT EXISTS (
    SELECT 1 FROM public.taches t
    WHERE t.epreuve = 'expression_orale'
      AND t.numero_tache = 2
      AND (t.reference = q.reference OR t.consigne = q.texte)
  );
