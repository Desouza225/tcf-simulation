
-- Fonction helper : un professeur peut-il lire ce profil étudiant ?
CREATE OR REPLACE FUNCTION can_prof_view_student(student_id uuid)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM attributions
    WHERE professeur_id = auth.uid()
      AND etudiant_id = student_id
  );
$$;

-- Politique : professeur peut lire les profils de ses étudiants attribués
CREATE POLICY "Professeur peut voir ses etudiants attribues"
  ON public.profiles
  FOR SELECT
  TO authenticated
  USING (can_prof_view_student(id));

-- Politique : étudiant peut lire le profil de son professeur attribué
CREATE POLICY "Etudiant peut voir son professeur attribue"
  ON public.profiles
  FOR SELECT
  TO authenticated
  USING (
    EXISTS (
      SELECT 1 FROM attributions
      WHERE etudiant_id = auth.uid()
        AND professeur_id = profiles.id
    )
  );
