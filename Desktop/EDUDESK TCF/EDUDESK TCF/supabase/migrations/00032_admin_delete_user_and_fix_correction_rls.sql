-- Migration 00032: RPC admin_delete_user & renforcement des politiques RLS de correction

-- ─── 1. Fonction RPC admin_delete_user ─────────────────────────────────────────
-- Permet aux administrateurs de supprimer définitivement un utilisateur et toutes ses données
CREATE OR REPLACE FUNCTION public.admin_delete_user(target_user_id uuid)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public, auth
AS $$
DECLARE
  v_caller_id   uuid;
  v_caller_role text;
  v_target_role text;
  v_target_email text;
  v_target_nom text;
  v_target_prenom text;
BEGIN
  v_caller_id := auth.uid();
  IF v_caller_id IS NULL THEN
    RAISE EXCEPTION 'Non authentifié.';
  END IF;

  -- Récupérer le rôle de l'appelant
  SELECT role INTO v_caller_role FROM public.profiles WHERE id = v_caller_id;
  IF v_caller_role IS NULL OR v_caller_role NOT IN ('admin', 'super_admin') THEN
    RAISE EXCEPTION 'Accès refusé. Vous devez être administrateur.';
  END IF;

  -- Récupérer le profil cible
  SELECT role, email, nom, prenom 
  INTO v_target_role, v_target_email, v_target_nom, v_target_prenom 
  FROM public.profiles WHERE id = target_user_id;

  -- Si le profil n'existe pas dans profiles, vérifier dans auth.users
  IF v_target_role IS NULL THEN
    IF NOT EXISTS (SELECT 1 FROM auth.users WHERE id = target_user_id) THEN
      RETURN jsonb_build_object('success', true, 'message', 'Utilisateur déjà supprimé.');
    END IF;
  END IF;

  -- Interdire la suppression d'un super_admin
  IF v_target_role = 'super_admin' THEN
    RAISE EXCEPTION 'Impossible de supprimer un Super Administrateur.';
  END IF;

  -- Un admin simple ne peut pas supprimer un autre admin
  IF v_caller_role = 'admin' AND v_target_role = 'admin' THEN
    RAISE EXCEPTION 'Un administrateur ne peut pas supprimer un autre administrateur.';
  END IF;

  -- Journaliser dans audit_suppressions si la table existe
  IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'audit_suppressions') THEN
    INSERT INTO public.audit_suppressions (
      profil_id, role, email, prenom, nom, raison, supprime_at
    ) VALUES (
      target_user_id, COALESCE(v_target_role, 'inconnu'), v_target_email, v_target_prenom, v_target_nom, 'suppression_manuelle_admin', now()
    );
  END IF;

  -- Supprimer les dépendances explicites
  DELETE FROM public.attributions WHERE etudiant_id = target_user_id OR professeur_id = target_user_id;
  DELETE FROM public.notifications WHERE utilisateur_id = target_user_id;
  DELETE FROM public.reponses_qcm WHERE session_id IN (SELECT id FROM public.sessions_examen WHERE etudiant_id = target_user_id);
  DELETE FROM public.productions WHERE etudiant_id = target_user_id;
  DELETE FROM public.sessions_examen WHERE etudiant_id = target_user_id;
  DELETE FROM public.abonnements WHERE etudiant_id = target_user_id;
  DELETE FROM public.paiements WHERE etudiant_id = target_user_id;

  -- Supprimer le profil public
  DELETE FROM public.profiles WHERE id = target_user_id;

  -- Supprimer le compte auth
  DELETE FROM auth.users WHERE id = target_user_id;

  RETURN jsonb_build_object('success', true, 'user_id', target_user_id);
END;
$$;

-- Donner les droits d'exécution aux utilisateurs authentifiés (la fonction vérifie le rôle admin à l'intérieur)
GRANT EXECUTE ON FUNCTION public.admin_delete_user(uuid) TO authenticated;

-- ─── 2. RLS sur productions ──────────────────────────────────────────────────
-- S'assurer que les professeurs peuvent voir et mettre à jour les productions de leurs étudiants attribués
DROP POLICY IF EXISTS "Professeur can view and correct attributed student productions" ON public.productions;
DROP POLICY IF EXISTS "Professeur can view and update attributed student productions" ON public.productions;

CREATE POLICY "Professeur can view and update attributed student productions" ON public.productions
  FOR ALL
  TO authenticated
  USING (
    professeur_id = auth.uid()
    OR EXISTS (
      SELECT 1 FROM public.attributions a
      WHERE a.etudiant_id = productions.etudiant_id
        AND a.professeur_id = auth.uid()
    )
    OR (
      SELECT role FROM public.profiles WHERE id = auth.uid()
    ) IN ('admin', 'super_admin')
  )
  WITH CHECK (
    professeur_id = auth.uid()
    OR EXISTS (
      SELECT 1 FROM public.attributions a
      WHERE a.etudiant_id = productions.etudiant_id
        AND a.professeur_id = auth.uid()
    )
    OR (
      SELECT role FROM public.profiles WHERE id = auth.uid()
    ) IN ('admin', 'super_admin')
  );

-- ─── 3. RLS sur sessions_examen ──────────────────────────────────────────────
-- S'assurer que le professeur peut mettre à jour les sessions d'examen après correction
DROP POLICY IF EXISTS "Professeur peut mettre a jour les sessions de ses etudiants" ON public.sessions_examen;

CREATE POLICY "Professeur peut mettre a jour les sessions de ses etudiants"
  ON public.sessions_examen
  FOR UPDATE
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM public.attributions a
      WHERE a.etudiant_id = sessions_examen.etudiant_id
        AND a.professeur_id = auth.uid()
    )
    OR EXISTS (
      SELECT 1 FROM public.productions p
      WHERE p.session_id = sessions_examen.id
        AND p.professeur_id = auth.uid()
    )
    OR (
      SELECT role FROM public.profiles WHERE id = auth.uid()
    ) IN ('admin', 'super_admin')
  )
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.attributions a
      WHERE a.etudiant_id = sessions_examen.etudiant_id
        AND a.professeur_id = auth.uid()
    )
    OR EXISTS (
      SELECT 1 FROM public.productions p
      WHERE p.session_id = sessions_examen.id
        AND p.professeur_id = auth.uid()
    )
    OR (
      SELECT role FROM public.profiles WHERE id = auth.uid()
    ) IN ('admin', 'super_admin')
  );

-- ─── 4. RLS sur notifications ─────────────────────────────────────────────────
-- Autoriser les professeurs à envoyer des notifications à leurs étudiants
DROP POLICY IF EXISTS "Professeur can insert notifications for students" ON public.notifications;

CREATE POLICY "Professeur can insert notifications for students"
  ON public.notifications
  FOR INSERT
  TO authenticated
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.attributions a
      WHERE a.etudiant_id = notifications.utilisateur_id
        AND a.professeur_id = auth.uid()
    )
    OR (
      SELECT role FROM public.profiles WHERE id = auth.uid()
    ) IN ('professeur', 'admin', 'super_admin')
  );
