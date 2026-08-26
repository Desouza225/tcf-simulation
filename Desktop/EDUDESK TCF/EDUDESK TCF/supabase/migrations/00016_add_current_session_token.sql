
-- Token de session unique : une seule connexion active par utilisateur
ALTER TABLE profiles ADD COLUMN IF NOT EXISTS current_session_token uuid;

-- Index pour les lookups de validation rapide
CREATE INDEX IF NOT EXISTS idx_profiles_session_token
  ON profiles(current_session_token)
  WHERE current_session_token IS NOT NULL;

-- Politique SELECT : l'utilisateur peut lire son propre current_session_token
-- (déjà couvert par "Users view own profile")
-- Politique UPDATE : l'utilisateur peut mettre à jour son propre token
-- (déjà couvert par "Users update own profile")
