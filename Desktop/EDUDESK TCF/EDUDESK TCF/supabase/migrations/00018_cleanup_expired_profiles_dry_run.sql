-- Correction 5 — Ajouter le mode dry_run à cleanup_expired_profiles
-- dry_run = true → SELECT seulement, aucun DELETE ni INSERT dans audit_suppressions
-- dry_run = false → comportement actuel (DELETE + audit) — valeur par défaut
CREATE OR REPLACE FUNCTION public.cleanup_expired_profiles(dry_run boolean DEFAULT false)
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_profile     RECORD;
  v_deleted_ids uuid[] := '{}';
  v_count       int    := 0;
  v_result      jsonb;
BEGIN
  FOR v_profile IN
    SELECT
      p.id,
      p.role,
      p.email,
      p.prenom,
      p.nom,
      p.created_at,
      p.last_active_at,
      CASE
        WHEN p.role = 'etudiant' AND p.created_at < now() - INTERVAL '1 year'
          THEN 'expiration_1_an'
        WHEN p.role = 'etudiant'
          AND COALESCE(p.last_active_at, p.created_at) < now() - INTERVAL '5 months'
          THEN 'inactivite_etudiant'
        WHEN p.role = 'professeur'
          AND COALESCE(p.last_active_at, p.created_at) < now() - INTERVAL '3 months'
          THEN 'inactivite_professeur'
      END AS raison
    FROM profiles p
    WHERE p.role IN ('etudiant', 'professeur')
      AND (
        (p.role = 'etudiant' AND p.created_at < now() - INTERVAL '1 year')
        OR (p.role = 'etudiant'
            AND COALESCE(p.last_active_at, p.created_at) < now() - INTERVAL '5 months')
        OR (p.role = 'professeur'
            AND COALESCE(p.last_active_at, p.created_at) < now() - INTERVAL '3 months')
      )
  LOOP
    IF dry_run THEN
      -- Mode simulation : on collecte uniquement, aucune modification
      v_deleted_ids := array_append(v_deleted_ids, v_profile.id);
      v_count := v_count + 1;
    ELSE
      -- Mode réel : journaliser puis supprimer
      INSERT INTO audit_suppressions (
        profil_id, role, email, prenom, nom, raison,
        created_at_profil, last_active_at
      ) VALUES (
        v_profile.id, v_profile.role, v_profile.email,
        v_profile.prenom, v_profile.nom, v_profile.raison,
        v_profile.created_at, v_profile.last_active_at
      );

      DELETE FROM profiles WHERE id = v_profile.id;
      DELETE FROM auth.users WHERE id = v_profile.id;

      v_deleted_ids := array_append(v_deleted_ids, v_profile.id);
      v_count := v_count + 1;
    END IF;
  END LOOP;

  RETURN jsonb_build_object(
    'deleted_count', v_count,
    'deleted_ids',   to_jsonb(v_deleted_ids),
    'executed_at',   now(),
    'dry_run',       dry_run
  );
END;
$$;