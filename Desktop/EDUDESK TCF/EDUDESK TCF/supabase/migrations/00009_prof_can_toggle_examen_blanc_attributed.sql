
-- Fonction helper : un professeur peut-il modifier ce profil étudiant ?
CREATE OR REPLACE FUNCTION can_prof_update_student(student_id uuid)
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

-- Politique UPDATE : professeur peut basculer examen_blanc_actif de ses étudiants attribués
CREATE POLICY "Professeur peut modifier examen_blanc de ses etudiants"
  ON public.profiles
  FOR UPDATE
  TO authenticated
  USING (
    can_prof_update_student(id)
    AND EXISTS (
      SELECT 1 FROM profiles p WHERE p.id = auth.uid() AND p.role = 'professeur'
    )
  )
  WITH CHECK (
    can_prof_update_student(id)
    AND EXISTS (
      SELECT 1 FROM profiles p WHERE p.id = auth.uid() AND p.role = 'professeur'
    )
  );
