-- Durée passée par l'étudiant sur l'épreuve d'expression écrite (en secondes)
ALTER TABLE sessions_examen
  ADD COLUMN duree_expression_ecrite integer DEFAULT NULL;
