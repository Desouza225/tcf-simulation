
-- Fonction qui vérifie le rôle sans récursion (lit directement auth.jwt())
CREATE OR REPLACE FUNCTION is_role_professeur()
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM auth.users
    WHERE id = auth.uid()
      AND raw_user_meta_data->>'role' = 'professeur'
  );
$$;

-- Fonction fiable basée sur la table profiles mais avec SECURITY DEFINER (bypass RLS)
CREATE OR REPLACE FUNCTION get_own_role()
RETURNS user_role
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT role FROM public.profiles WHERE id = auth.uid();
$$;

-- Supprimer l'ancienne politique récursive
DROP POLICY IF EXISTS "Professeur peut modifier examen_blanc de ses etudiants" ON public.profiles;

-- Recréer sans récursion : USING utilise get_own_role() (SECURITY DEFINER) au lieu d'une sous-requête sur profiles
CREATE POLICY "Professeur peut modifier examen_blanc de ses etudiants"
  ON public.profiles
  FOR UPDATE
  TO authenticated
  USING (
    get_own_role() = 'professeur'
    AND can_prof_update_student(id)
  )
  WITH CHECK (
    get_own_role() = 'professeur'
    AND can_prof_update_student(id)
  );
