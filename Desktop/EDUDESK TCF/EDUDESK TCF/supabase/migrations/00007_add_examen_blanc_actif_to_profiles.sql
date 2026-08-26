
-- Ajouter la colonne examen_blanc_actif sur profiles
ALTER TABLE profiles ADD COLUMN examen_blanc_actif boolean NOT NULL DEFAULT false;

-- Politique RLS : les admins/profs/super_admins peuvent modifier examen_blanc_actif
-- (les policies existantes sur profiles couvrent déjà la lecture/écriture admin)
-- On crée une fonction helper pour vérifier si l'utilisateur peut gérer les étudiants
CREATE OR REPLACE FUNCTION can_manage_examen_blanc(target_etudiant_id uuid)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
AS $$
  SELECT EXISTS (
    SELECT 1 FROM profiles
    WHERE id = auth.uid()
    AND role IN ('admin', 'super_admin', 'professeur')
  );
$$;
