
-- Ajouter la valeur 'refuse' au type enum statut_correction
ALTER TYPE statut_correction ADD VALUE IF NOT EXISTS 'refuse';

-- Ajouter la colonne raison_refus sur les productions
ALTER TABLE productions ADD COLUMN IF NOT EXISTS raison_refus text DEFAULT NULL;
