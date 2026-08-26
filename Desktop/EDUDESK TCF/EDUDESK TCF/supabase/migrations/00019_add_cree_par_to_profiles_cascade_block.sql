
-- Ajouter cree_par sur profiles : l'admin qui a créé cet utilisateur
-- Nécessaire pour le blocage en cascade : si l'admin est bloqué,
-- tous les utilisateurs qu'il a créés (étudiants, professeurs) sont aussi bloqués.
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS cree_par uuid REFERENCES profiles(id) ON DELETE SET NULL;

-- Fonction helper pour vérifier si un profil est bloqué directement OU par son admin créateur
CREATE OR REPLACE FUNCTION is_access_blocked(p_id uuid)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT EXISTS (
    SELECT 1 FROM profiles p
    WHERE p.id = p_id
    AND (
      -- L'utilisateur lui-même est bloqué
      p.bloque = true
      OR
      -- Ou son admin créateur est bloqué
      EXISTS (
        SELECT 1 FROM profiles admin_p
        WHERE admin_p.id = p.cree_par
        AND admin_p.bloque = true
      )
    )
  );
$$;
