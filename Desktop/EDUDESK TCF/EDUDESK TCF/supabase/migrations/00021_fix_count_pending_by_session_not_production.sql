
-- Correction : compter les SESSIONS distinctes en attente, pas les productions individuelles.
-- Une session expression_orale avec 2 tâches = 1 épreuve soumise, pas 2.
-- La limite de 2 s'applique à 2 soumissions (sessions), indépendamment pour chaque épreuve.
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
    AND pr.statut_correction <> 'corrige'
    AND se.mode = 'entrainement';
$$;
