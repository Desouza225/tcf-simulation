-- ==============================================================================
-- Migration 00038: Table des paramètres globaux de la plateforme
-- (Optimisation audio, clarté vocale, etc.)
-- ==============================================================================

CREATE TABLE IF NOT EXISTS public.parametres_globaux (
  cle text PRIMARY KEY,
  valeur jsonb NOT NULL,
  description text,
  updated_at timestamptz NOT NULL DEFAULT now(),
  updated_by uuid REFERENCES public.profiles(id)
);

ALTER TABLE public.parametres_globaux ENABLE ROW LEVEL SECURITY;

-- 1. Tout le monde peut LIRE les paramètres globaux (candidats, professeurs, visiteurs)
CREATE POLICY "Lecture publique des parametres globaux"
ON public.parametres_globaux
FOR SELECT
TO public
USING (true);

-- 2. Seuls les administrateurs et super_admins peuvent MODIFIER ou AJOUTER des paramètres
CREATE POLICY "Modification des parametres par admin uniquement"
ON public.parametres_globaux
FOR ALL
TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM public.profiles
    WHERE profiles.id = auth.uid()
      AND profiles.role IN ('admin', 'super_admin')
  )
)
WITH CHECK (
  EXISTS (
    SELECT 1 FROM public.profiles
    WHERE profiles.id = auth.uid()
      AND profiles.role IN ('admin', 'super_admin')
  )
);

-- 3. Insertion du paramètre d'optimisation audio et clarté vocale (activé par défaut)
INSERT INTO public.parametres_globaux (cle, valeur, description)
VALUES (
  'audio_clarity_enabled',
  'true'::jsonb,
  'Active le traitement de clarté vocale et la normalisation dynamique du volume pour tous les candidats en Compréhension Orale'
)
ON CONFLICT (cle) DO UPDATE
SET valeur = EXCLUDED.valeur,
    description = EXCLUDED.description;
