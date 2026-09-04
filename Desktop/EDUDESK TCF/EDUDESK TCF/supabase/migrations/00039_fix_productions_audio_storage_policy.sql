-- ============================================================================
-- Migration 00039: Assurer la lecture publique et l'accès au bucket productions-audio
-- ============================================================================

-- 1. Mettre à jour le bucket pour garantir qu'il est public
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'productions-audio',
  'productions-audio',
  true,
  52428800,
  ARRAY['audio/webm', 'audio/ogg', 'audio/mp4', 'audio/mpeg', 'audio/wav', 'audio/aac', 'audio/x-m4a']
)
ON CONFLICT (id) DO UPDATE SET
  public = true,
  file_size_limit = 52428800;

-- 2. Assurer que la politique SELECT sur storage.objects est accordée à TOUS (public / anon / authenticated)
DROP POLICY IF EXISTS "Lecture publique productions-audio" ON storage.objects;
DROP POLICY IF EXISTS "Tout le monde peut lire productions-audio" ON storage.objects;
DROP POLICY IF EXISTS "Public Access productions-audio" ON storage.objects;

CREATE POLICY "Tout le monde peut lire productions-audio"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'productions-audio');
