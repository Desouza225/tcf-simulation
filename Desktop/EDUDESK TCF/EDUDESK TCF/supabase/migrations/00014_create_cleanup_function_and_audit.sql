
-- ─── 1. Table d'audit des suppressions ───────────────────────────────────────
CREATE TABLE IF NOT EXISTS audit_suppressions (
  id                uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  profil_id         uuid        NOT NULL,
  role              text        NOT NULL,
  email             text,
  prenom            text,
  nom               text,
  raison            text        NOT NULL,
  created_at_profil timestamptz,
  last_active_at    timestamptz,
  supprime_at       timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE audit_suppressions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Admin peut lire audit suppressions"
  ON audit_suppressions FOR SELECT TO authenticated
  USING (is_admin_or_super(auth.uid()));

-- ─── 2. Fonction principale de nettoyage ─────────────────────────────────────
CREATE OR REPLACE FUNCTION cleanup_expired_profiles()
RETURNS jsonb
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_profile     RECORD;
  v_deleted_ids uuid[] := '{}';
  v_count       int    := 0;
  v_raison      text;
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
    -- Journaliser avant suppression
    INSERT INTO audit_suppressions (
      profil_id, role, email, prenom, nom, raison,
      created_at_profil, last_active_at
    ) VALUES (
      v_profile.id, v_profile.role, v_profile.email,
      v_profile.prenom, v_profile.nom, v_profile.raison,
      v_profile.created_at, v_profile.last_active_at
    );

    -- Supprimer le profil (CASCADE vers toutes les tables liées)
    DELETE FROM profiles WHERE id = v_profile.id;

    -- Supprimer le compte auth
    DELETE FROM auth.users WHERE id = v_profile.id;

    v_deleted_ids := array_append(v_deleted_ids, v_profile.id);
    v_count := v_count + 1;
  END LOOP;

  RETURN jsonb_build_object(
    'deleted_count', v_count,
    'deleted_ids',   to_jsonb(v_deleted_ids),
    'executed_at',   now()
  );
END;
$$;
