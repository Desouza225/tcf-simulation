-- Bucket pour les images des questions
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'question-images',
  'question-images',
  true,
  5242880,  -- 5 MB
  ARRAY['image/jpeg','image/png','image/webp','image/gif']
);

-- Bucket pour les fichiers audio des questions
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'question-audio',
  'question-audio',
  true,
  31457280,  -- 30 MB
  ARRAY['audio/mpeg','audio/wav','audio/ogg','audio/mp4','audio/aac','audio/x-m4a']
);