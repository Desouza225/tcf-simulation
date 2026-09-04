-- ==============================================================================
-- Migration 00035: Grille d'évaluation officielle Expression Écrite TCF Canada (20 pts)
-- et table de conversion CECRL correspondante
-- ==============================================================================

-- 1. Table de configuration pour la grille d'expression écrite et conversion CECRL
CREATE TABLE IF NOT EXISTS public.grilles_evaluation (
  id text PRIMARY KEY,
  epreuve text NOT NULL,
  total_points numeric NOT NULL,
  mode_notation text NOT NULL,
  grille_structure jsonb NOT NULL,
  conversion_cecrl jsonb NOT NULL,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Activer RLS sur grilles_evaluation
ALTER TABLE public.grilles_evaluation ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Anyone authenticated can view grilles" ON public.grilles_evaluation;
CREATE POLICY "Anyone authenticated can view grilles"
  ON public.grilles_evaluation FOR SELECT
  TO authenticated
  USING (true);

-- 2. Insertion de la grille officielle Expression Écrite TCF Canada (3 dimensions, 20 points)
INSERT INTO public.grilles_evaluation (id, epreuve, total_points, mode_notation, grille_structure, conversion_cecrl)
VALUES (
  'expression_ecrite_tcf',
  'expression_ecrite',
  20,
  'manuel_professeur',
  '{
    "dimensions": [
      {
        "nom": "Compétence linguistique",
        "points_max": 8,
        "criteres": [
          { "nom": "Étendue du lexique", "points_max": 2, "description": "Vocabulaire varié, précis, adapté au sujet. Évite les répétitions excessives." },
          { "nom": "Maîtrise du lexique", "points_max": 2, "description": "Choix des mots appropriés au contexte et au registre." },
          { "nom": "Correction grammaticale", "points_max": 2, "description": "Conjugaison correcte, accords (sujet-verbe, nom-adjectif), structures de phrases variées." },
          { "nom": "Orthographe et ponctuation", "points_max": 2, "description": "Orthographe lexicale et grammaticale correcte. Ponctuation appropriée." }
        ]
      },
      {
        "nom": "Compétence pragmatique",
        "points_max": 8,
        "criteres": [
          { "nom": "Respect de la consigne", "points_max": 3, "description": "Réponse complète à la tâche demandée. Nombre de mots respecté (±10%). Format approprié (message, article, lettre)." },
          { "nom": "Cohérence et cohésion", "points_max": 3, "description": "Clarté structurelle : organisation logique du texte (paragraphes, plan visible), connecteurs (d''abord, ensuite, cependant, donc), idées enchaînées sans rupture ni contradiction." },
          { "nom": "Développement thématique", "points_max": 2, "description": "Idées développées avec exemples, arguments ou explications. Pas de hors-sujet." }
        ]
      },
      {
        "nom": "Compétence sociolinguistique",
        "points_max": 4,
        "criteres": [
          { "nom": "Registre de langue et adéquation", "points_max": 2, "description": "Le ton, le style et les formules correspondent au destinataire (ami, collègue, administration)." },
          { "nom": "Clarté de la communication", "points_max": 2, "description": "Clarté communicative : même si le texte est bien structuré, le destinataire comprend-il immédiatement l''intention (informer, convaincre, demander, expliquer) et ce qu''on attend de lui ?" }
        ]
      }
    ]
  }'::jsonb,
  '[
    { "score_min": 0, "score_max": 3, "niveau_cecrl": "A1" },
    { "score_min": 4, "score_max": 5, "niveau_cecrl": "A2" },
    { "score_min": 6, "score_max": 9, "niveau_cecrl": "B1" },
    { "score_min": 10, "score_max": 13, "niveau_cecrl": "B2" },
    { "score_min": 14, "score_max": 15, "niveau_cecrl": "C1" },
    { "score_min": 16, "score_max": 20, "niveau_cecrl": "C1-C2" }
  ]'::jsonb
)
ON CONFLICT (id) DO UPDATE SET
  grille_structure = EXCLUDED.grille_structure,
  conversion_cecrl = EXCLUDED.conversion_cecrl,
  updated_at = now();

-- 3. Fonction SQL de conversion Expression Écrite (Score /20 -> Niveau CECRL)
CREATE OR REPLACE FUNCTION public.convert_score_ee_to_cecrl(p_score numeric)
RETURNS text
LANGUAGE sql
IMMUTABLE
AS $$
  SELECT CASE
    WHEN p_score >= 16 THEN 'C2'
    WHEN p_score >= 14 THEN 'C1'
    WHEN p_score >= 10 THEN 'B2'
    WHEN p_score >= 6  THEN 'B1'
    WHEN p_score >= 4  THEN 'A2'
    ELSE 'A1'
  END;
$$;
