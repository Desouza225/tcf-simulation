-- Migration 00026: Ajouter la colonne reference et nettoyer les faux sujets d'expression écrite

-- 1. Ajouter la colonne reference aux tables questions, taches et productions
ALTER TABLE public.questions ADD COLUMN IF NOT EXISTS reference text;
ALTER TABLE public.taches ADD COLUMN IF NOT EXISTS reference text;
ALTER TABLE public.productions ADD COLUMN IF NOT EXISTS reference text;

-- Index pour recherche rapide par référence
CREATE INDEX IF NOT EXISTS idx_questions_reference ON public.questions(reference);
CREATE INDEX IF NOT EXISTS idx_taches_reference ON public.taches(reference);

-- 2. Nettoyage des faux sujets générés artificiellement (ex: EE_T3_895 ou mix Document 1 / Document 2)
DELETE FROM public.questions 
WHERE (epreuve = 'expression_ecrite' OR epreuve = 'expression_orale')
  AND (
    texte LIKE '%EE_T3_%' 
    OR texte LIKE '%EE_T%'
    OR (texte LIKE '%Document 1%' AND texte LIKE '%Document 2%')
  );
