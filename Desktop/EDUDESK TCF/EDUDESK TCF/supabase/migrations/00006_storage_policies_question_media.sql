-- ====================================================
-- Policies Storage : question-images
-- ====================================================

-- Lecture publique (les étudiants voient les images pendant l'examen)
CREATE POLICY "Images questions : lecture publique"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'question-images');

-- Upload : admins et super_admin seulement
CREATE POLICY "Images questions : upload admin"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (
    bucket_id = 'question-images'
    AND is_admin_or_super(auth.uid())
  );

-- Mise à jour : admins et super_admin seulement
CREATE POLICY "Images questions : update admin"
  ON storage.objects FOR UPDATE
  TO authenticated
  USING (
    bucket_id = 'question-images'
    AND is_admin_or_super(auth.uid())
  );

-- Suppression : admins et super_admin seulement
CREATE POLICY "Images questions : delete admin"
  ON storage.objects FOR DELETE
  TO authenticated
  USING (
    bucket_id = 'question-images'
    AND is_admin_or_super(auth.uid())
  );

-- ====================================================
-- Policies Storage : question-audio
-- ====================================================

-- Lecture publique (les étudiants écoutent l'audio pendant l'examen)
CREATE POLICY "Audio questions : lecture publique"
  ON storage.objects FOR SELECT
  USING (bucket_id = 'question-audio');

-- Upload : admins et super_admin seulement
CREATE POLICY "Audio questions : upload admin"
  ON storage.objects FOR INSERT
  TO authenticated
  WITH CHECK (
    bucket_id = 'question-audio'
    AND is_admin_or_super(auth.uid())
  );

-- Mise à jour : admins et super_admin seulement
CREATE POLICY "Audio questions : update admin"
  ON storage.objects FOR UPDATE
  TO authenticated
  USING (
    bucket_id = 'question-audio'
    AND is_admin_or_super(auth.uid())
  );

-- Suppression : admins et super_admin seulement
CREATE POLICY "Audio questions : delete admin"
  ON storage.objects FOR DELETE
  TO authenticated
  USING (
    bucket_id = 'question-audio'
    AND is_admin_or_super(auth.uid())
  );