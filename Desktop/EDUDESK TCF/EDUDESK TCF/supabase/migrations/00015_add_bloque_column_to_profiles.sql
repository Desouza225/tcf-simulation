
-- ─── 1. Colonne bloque ────────────────────────────────────────────────────────
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS bloque boolean NOT NULL DEFAULT false;

-- ─── 2. Fonction helper pour l'enforcement côté app ──────────────────────────
-- Retourne true si le profil courant est bloqué (utilisé dans les guards)
CREATE OR REPLACE FUNCTION is_profile_bloque(p_id uuid)
RETURNS boolean
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT COALESCE(bloque, false) FROM profiles WHERE id = p_id;
$$;

-- ─── 3. La politique UPDATE professeur couvre déjà le champ bloque
-- "Professeur peut modifier examen_blanc de ses etudiants" s'applique à tous les champs
-- pour les étudiants attribués → OK, pas de nouvelle politique nécessaire.
-- Admin UPDATE policy couvre professeur+étudiant → OK.
-- Super admin ALL policy → OK.
