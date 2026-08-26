
-- Corriger les sessions existantes où correction_complete est resté false
-- alors que toutes les productions d'expression (EE/EO) sont corrigées.
-- Cela corrige le bug causé par les productions QCM (sans professeur_id)
-- qui restaient en statut 'en_attente' sans jamais être marquées 'corrige'.
UPDATE sessions_examen se
SET correction_complete = true
WHERE se.correction_complete = false
  AND se.statut = 'termine'
  -- La session doit avoir au moins une production d'expression
  AND EXISTS (
    SELECT 1 FROM productions p
    WHERE p.session_id = se.id
      AND p.epreuve IN ('expression_ecrite', 'expression_orale')
  )
  -- Aucune production d'expression ne doit être encore en attente
  AND NOT EXISTS (
    SELECT 1 FROM productions p
    WHERE p.session_id = se.id
      AND p.epreuve IN ('expression_ecrite', 'expression_orale')
      AND p.statut_correction != 'corrige'
  );
