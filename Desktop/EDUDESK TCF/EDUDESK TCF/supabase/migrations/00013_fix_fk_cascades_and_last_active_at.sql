
-- ─── 1. Corriger les FK NO ACTION ────────────────────────────────────────────

-- productions.etudiant_id → CASCADE (supprimer les productions de l'étudiant)
ALTER TABLE productions DROP CONSTRAINT IF EXISTS productions_etudiant_id_fkey;
ALTER TABLE productions ADD CONSTRAINT productions_etudiant_id_fkey
  FOREIGN KEY (etudiant_id) REFERENCES profiles(id) ON DELETE CASCADE;

-- productions.professeur_id → SET NULL (garder les productions corrigées)
ALTER TABLE productions DROP CONSTRAINT IF EXISTS productions_professeur_id_fkey;
ALTER TABLE productions ADD CONSTRAINT productions_professeur_id_fkey
  FOREIGN KEY (professeur_id) REFERENCES profiles(id) ON DELETE SET NULL;

-- attributions.attribue_par → SET NULL
ALTER TABLE attributions DROP CONSTRAINT IF EXISTS attributions_attribue_par_fkey;
ALTER TABLE attributions ADD CONSTRAINT attributions_attribue_par_fkey
  FOREIGN KEY (attribue_par) REFERENCES profiles(id) ON DELETE SET NULL;

-- questions.cree_par → SET NULL (garder les questions dans la banque)
ALTER TABLE questions DROP CONSTRAINT IF EXISTS questions_cree_par_fkey;
ALTER TABLE questions ADD CONSTRAINT questions_cree_par_fkey
  FOREIGN KEY (cree_par) REFERENCES profiles(id) ON DELETE SET NULL;

-- taches.cree_par → SET NULL (garder les tâches)
ALTER TABLE taches DROP CONSTRAINT IF EXISTS taches_cree_par_fkey;
ALTER TABLE taches ADD CONSTRAINT taches_cree_par_fkey
  FOREIGN KEY (cree_par) REFERENCES profiles(id) ON DELETE SET NULL;

-- ─── 2. Colonne last_active_at sur profiles ───────────────────────────────────
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS last_active_at timestamptz DEFAULT now();

-- Initialiser last_active_at à partir de auth.users.last_sign_in_at
UPDATE profiles p
SET last_active_at = COALESCE(u.last_sign_in_at, u.created_at)
FROM auth.users u
WHERE u.id = p.id;

-- ─── 3. Trigger : mettre à jour last_active_at à chaque connexion ─────────────
CREATE OR REPLACE FUNCTION sync_last_active_at()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  IF NEW.last_sign_in_at IS DISTINCT FROM OLD.last_sign_in_at THEN
    UPDATE public.profiles
    SET last_active_at = NEW.last_sign_in_at
    WHERE id = NEW.id;
  END IF;
  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_sync_last_active_at ON auth.users;
CREATE TRIGGER trg_sync_last_active_at
  AFTER UPDATE OF last_sign_in_at ON auth.users
  FOR EACH ROW EXECUTE FUNCTION sync_last_active_at();
