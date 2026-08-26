
-- Fonction RPC : compte les productions en attente de correction
-- pour un étudiant, une épreuve et le mode entraînement.
-- Utilisée par le frontend pour bloquer l'accès si ≥ 2 en attente.
CREATE OR REPLACE FUNCTION count_pending_expression_entrainement(
  p_etudiant_id uuid,
  p_epreuve text
)
RETURNS integer
LANGUAGE sql
SECURITY DEFINER
STABLE
AS $$
  SELECT COUNT(*)::integer
  FROM productions pr
  JOIN sessions_examen se ON se.id = pr.session_id
  WHERE pr.etudiant_id = p_etudiant_id
    AND pr.epreuve = p_epreuve::epreuve_type
    AND pr.statut_correction <> 'corrige'
    AND se.mode = 'entrainement';
$$;

-- Accorder l'exécution aux utilisateurs authentifiés
GRANT EXECUTE ON FUNCTION count_pending_expression_entrainement(uuid, text) TO authenticated;
