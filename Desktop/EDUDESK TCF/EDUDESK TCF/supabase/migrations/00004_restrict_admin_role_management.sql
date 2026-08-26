-- Supprimer la policy trop permissive "Admin full access profiles"
DROP POLICY "Admin full access profiles" ON public.profiles;

-- Fonction helper : vérifier qu'un profil cible est gérable par un admin simple
CREATE OR REPLACE FUNCTION can_admin_manage_profile(target_id uuid)
RETURNS boolean
LANGUAGE sql SECURITY DEFINER STABLE
AS $$
  -- Admin simple peut gérer uniquement les professeurs et étudiants
  SELECT EXISTS (
    SELECT 1 FROM public.profiles
    WHERE id = target_id
      AND role IN ('professeur', 'etudiant')
  );
$$;

-- Politique SELECT : admin voit professeurs et étudiants seulement
CREATE POLICY "Admin select non-privileged profiles"
  ON public.profiles
  FOR SELECT
  TO authenticated
  USING (
    is_admin_or_super(auth.uid())
    AND (
      is_super_admin(auth.uid())
      OR role IN ('professeur', 'etudiant')
    )
  );

-- Politique INSERT : admin crée uniquement professeur/étudiant, super_admin crée aussi admin
CREATE POLICY "Admin insert profiles by role"
  ON public.profiles
  FOR INSERT
  TO authenticated
  WITH CHECK (
    is_admin_or_super(auth.uid())
    AND (
      is_super_admin(auth.uid())
        AND role IN ('admin', 'professeur', 'etudiant')
      OR
      (NOT is_super_admin(auth.uid()))
        AND role IN ('professeur', 'etudiant')
    )
  );

-- Politique UPDATE : admin modifie uniquement professeur/étudiant et ne peut pas changer le rôle en admin
CREATE POLICY "Admin update profiles by role"
  ON public.profiles
  FOR UPDATE
  TO authenticated
  USING (
    is_admin_or_super(auth.uid())
    AND (
      is_super_admin(auth.uid())
        AND role IN ('admin', 'professeur', 'etudiant')
      OR
      (NOT is_super_admin(auth.uid()))
        AND role IN ('professeur', 'etudiant')
    )
  )
  WITH CHECK (
    is_admin_or_super(auth.uid())
    AND (
      is_super_admin(auth.uid())
        AND role IN ('admin', 'professeur', 'etudiant')
      OR
      (NOT is_super_admin(auth.uid()))
        AND role IN ('professeur', 'etudiant')
    )
  );

-- Politique DELETE : admin supprime uniquement professeur/étudiant
CREATE POLICY "Admin delete profiles by role"
  ON public.profiles
  FOR DELETE
  TO authenticated
  USING (
    is_admin_or_super(auth.uid())
    AND (
      is_super_admin(auth.uid())
        AND role IN ('admin', 'professeur', 'etudiant')
      OR
      (NOT is_super_admin(auth.uid()))
        AND role IN ('professeur', 'etudiant')
    )
  );