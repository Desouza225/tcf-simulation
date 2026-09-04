-- ==============================================================================
-- Migration 00037: Nettoyage et prévention des doublons dans la table questions
-- (Compréhension Orale et Compréhension Écrite)
-- ==============================================================================

-- 1. Supprimer les doublons basés sur l'audio_url (pour la Compréhension Orale)
DELETE FROM public.questions a
USING public.questions b
WHERE a.id > b.id
  AND a.epreuve = b.epreuve
  AND a.audio_url IS NOT NULL
  AND b.audio_url IS NOT NULL
  AND TRIM(a.audio_url) != ''
  AND TRIM(b.audio_url) != ''
  AND a.audio_url = b.audio_url;

-- 2. Supprimer les doublons basés sur la référence (ex: CO_T01_Q01, CE_001)
DELETE FROM public.questions a
USING public.questions b
WHERE a.id > b.id
  AND a.epreuve = b.epreuve
  AND a.reference IS NOT NULL
  AND b.reference IS NOT NULL
  AND TRIM(a.reference) != ''
  AND TRIM(b.reference) != ''
  AND a.reference = b.reference;

-- 3. Supprimer les doublons basés sur le texte exact et les choix
DELETE FROM public.questions a
USING public.questions b
WHERE a.id > b.id
  AND a.epreuve = b.epreuve
  AND a.texte IS NOT NULL
  AND b.texte IS NOT NULL
  AND TRIM(a.texte) != ''
  AND TRIM(b.texte) != ''
  AND a.texte = b.texte
  AND a.choix::text = b.choix::text;

-- 4. Création d'index uniques partiels pour empêcher physiquement tout doublon futur
CREATE UNIQUE INDEX IF NOT EXISTS idx_questions_unique_epreuve_audio
ON public.questions (epreuve, audio_url)
WHERE audio_url IS NOT NULL AND TRIM(audio_url) != '';

CREATE UNIQUE INDEX IF NOT EXISTS idx_questions_unique_epreuve_reference
ON public.questions (epreuve, reference)
WHERE reference IS NOT NULL AND TRIM(reference) != '';
