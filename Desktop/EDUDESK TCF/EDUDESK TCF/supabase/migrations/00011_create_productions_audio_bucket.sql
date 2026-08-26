
-- Créer le bucket productions-audio (public pour faciliter la lecture par le professeur)
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'productions-audio',
  'productions-audio',
  true,
  52428800, -- 50 MB
  ARRAY['audio/webm', 'audio/ogg', 'audio/mp4', 'audio/mpeg', 'audio/wav', 'audio/aac', 'audio/x-m4a']
);

-- Politique : un étudiant peut uploader dans son propre dossier (audio/<user_id>/...)
CREATE POLICY "Etudiant peut uploader son audio"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (
  bucket_id = 'productions-audio'
  AND (storage.foldername(name))[1] = 'audio'
  AND (storage.foldername(name))[2] = auth.uid()::text
);

-- Politique : lecture publique (bucket public, mais on ajoute quand même une policy explicite)
CREATE POLICY "Lecture publique productions-audio"
ON storage.objects FOR SELECT
TO authenticated
USING (bucket_id = 'productions-audio');

-- Politique : l'étudiant peut mettre à jour/remplacer son propre audio
CREATE POLICY "Etudiant peut remplacer son audio"
ON storage.objects FOR UPDATE
TO authenticated
USING (
  bucket_id = 'productions-audio'
  AND (storage.foldername(name))[2] = auth.uid()::text
);
