
-- Correction : une production refusée ne compte PAS comme "en attente" de correction.
-- L'étudiant doit pouvoir en soumettre une nouvelle immédiatement après un refus.
CREATE OR REPLACE FUNCTION count_pending_expression_entrainement(
  p_etudiant_id uuid,
  p_epreuve text
)
RETURNS integer
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT COUNT(DISTINCT pr.session_id)::integer
  FROM productions pr
  JOIN sessions_examen se ON se.id = pr.session_id
  WHERE pr.etudiant_id = p_etudiant_id
    AND pr.epreuve = p_epreuve::epreuve_type
    AND pr.statut_correction = 'en_attente'
    AND se.mode = 'entrainement';
$$;
