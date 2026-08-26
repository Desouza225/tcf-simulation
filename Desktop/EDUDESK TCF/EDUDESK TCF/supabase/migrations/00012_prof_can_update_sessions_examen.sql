
-- Fonction helper : le professeur peut-il mettre à jour cette session ?
CREATE OR REPLACE FUNCTION can_prof_update_session(session_etudiant_id uuid)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM attributions
    WHERE professeur_id = auth.uid()
      AND etudiant_id = session_etudiant_id
  );
$$;

-- Politique UPDATE : professeur peut écrire les scores de ses étudiants attribués
CREATE POLICY "Professeur peut mettre a jour les sessions de ses etudiants"
  ON public.sessions_examen
  FOR UPDATE
  TO authenticated
  USING (
    get_own_role() = 'professeur'
    AND can_prof_update_session(etudiant_id)
  )
  WITH CHECK (
    get_own_role() = 'professeur'
    AND can_prof_update_session(etudiant_id)
  );

-- Politique UPDATE admin (s'il manquait)
CREATE POLICY "Admin peut mettre a jour toutes les sessions"
  ON public.sessions_examen
  FOR UPDATE
  TO authenticated
  USING (is_admin_or_super(auth.uid()))
  WITH CHECK (is_admin_or_super(auth.uid()));
