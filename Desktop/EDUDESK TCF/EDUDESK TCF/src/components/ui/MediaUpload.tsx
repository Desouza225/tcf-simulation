import { useRef, useState } from 'react';
import { supabase } from '@/db/supabase';
import { Button } from '@/components/ui/button';
import { Skeleton } from '@/components/ui/skeleton';
import { toast } from 'sonner';
import { cn } from '@/lib/utils';
import {
  Upload, X, Image as ImageIcon, Music, Loader2, Eye,
} from 'lucide-react';

type MediaType = 'image' | 'audio';

interface MediaUploadProps {
  type: MediaType;
  value: string;                       // URL actuelle (vide = rien)
  onChange: (url: string) => void;     // appelé avec la nouvelle URL publique
  label?: string;
  className?: string;
}

const BUCKET: Record<MediaType, string> = {
  image: 'question-images',
  audio: 'question-audio',
};

const ACCEPT: Record<MediaType, string> = {
  image: 'image/jpeg,image/png,image/webp,image/gif',
  audio: 'audio/mpeg,audio/wav,audio/ogg,audio/mp4,audio/aac,audio/x-m4a',
};

const MAX_SIZE: Record<MediaType, number> = {
  image: 5 * 1024 * 1024,   // 5 Mo
  audio: 30 * 1024 * 1024,  // 30 Mo
};

const SIZE_LABEL: Record<MediaType, string> = {
  image: '5 Mo max · JPEG, PNG, WebP',
  audio: '30 Mo max · MP3, WAV, OGG, M4A',
};

/** Supprime un fichier Storage à partir de son URL publique */
async function deleteStorageFile(bucket: string, url: string) {
  try {
    // L'URL publique ressemble à : ...storage/v1/object/public/<bucket>/<path>
    const marker = `/object/public/${bucket}/`;
    const idx = url.indexOf(marker);
    if (idx === -1) return;
    const filePath = decodeURIComponent(url.slice(idx + marker.length));
    await supabase.storage.from(bucket).remove([filePath]);
  } catch {
    // Erreur silencieuse — le fichier peut déjà être absent
  }
}

export default function MediaUpload({
  type, value, onChange, label, className,
}: MediaUploadProps) {
  const inputRef = useRef<HTMLInputElement>(null);
  const [uploading, setUploading] = useState(false);
  const [dragOver, setDragOver] = useState(false);
  const [showPreview, setShowPreview] = useState(false);

  const hasFile = Boolean(value);
  const bucket = BUCKET[type];

  const handleFile = async (file: File) => {
    // Validation type MIME
    if (!ACCEPT[type].split(',').some(t => file.type === t.trim())) {
      toast.error(`Format non supporté. Formats acceptés : ${SIZE_LABEL[type]}`);
      return;
    }
    // Validation taille
    if (file.size > MAX_SIZE[type]) {
      toast.error(`Fichier trop lourd. Maximum : ${type === 'image' ? '5 Mo' : '30 Mo'}`);
      return;
    }

    setUploading(true);

    // Supprimer l'ancien fichier Storage si c'est un fichier hébergé sur notre Storage
    if (value && value.includes(`/object/public/${bucket}/`)) {
      await deleteStorageFile(bucket, value);
    }

    // Générer un nom de fichier unique
    const ext = file.name.split('.').pop() ?? (type === 'image' ? 'jpg' : 'mp3');
    const path = `${crypto.randomUUID()}.${ext}`;

    const { error: uploadError } = await supabase.storage
      .from(bucket)
      .upload(path, file, { contentType: file.type, upsert: false });

    if (uploadError) {
      toast.error(`Erreur lors de l'upload : ${uploadError.message}`);
      setUploading(false);
      return;
    }

    const { data } = supabase.storage.from(bucket).getPublicUrl(path);
    onChange(data.publicUrl);
    toast.success(type === 'image' ? 'Image chargée !' : 'Audio chargé !');
    setUploading(false);
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0];
    if (file) handleFile(file);
    // Réinitialiser pour permettre le re-upload du même fichier
    e.target.value = '';
  };

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault();
    setDragOver(false);
    const file = e.dataTransfer.files[0];
    if (file) handleFile(file);
  };

  const handleRemove = async () => {
    if (value && value.includes(`/object/public/${bucket}/`)) {
      await deleteStorageFile(bucket, value);
    }
    onChange('');
    toast.success(type === 'image' ? 'Image supprimée.' : 'Audio supprimé.');
  };

  // Nom de fichier court pour l'affichage
  const shortName = value
    ? decodeURIComponent(value.split('/').pop() ?? '').slice(0, 40)
    : '';

  return (
    <div className={cn('space-y-2', className)}>
      {label && (
        <p className="text-sm font-normal text-foreground">{label}</p>
      )}

      {/* Zone de dépôt / état vide */}
      {!hasFile && (
        <div
          className={cn(
            'relative flex flex-col items-center justify-center gap-2 rounded-lg border-2 border-dashed border-border p-6 text-center cursor-pointer transition-colors',
            dragOver && 'border-primary bg-primary/5',
            uploading && 'pointer-events-none opacity-60',
          )}
          onClick={() => inputRef.current?.click()}
          onDragOver={e => { e.preventDefault(); setDragOver(true); }}
          onDragLeave={() => setDragOver(false)}
          onDrop={handleDrop}
        >
          {uploading ? (
            <>
              <Loader2 className="w-7 h-7 text-primary animate-spin" />
              <p className="text-sm text-muted-foreground">Upload en cours…</p>
            </>
          ) : (
            <>
              {type === 'image'
                ? <ImageIcon className="w-7 h-7 text-muted-foreground/50" />
                : <Music className="w-7 h-7 text-muted-foreground/50" />}
              <div>
                <p className="text-sm font-medium text-foreground">
                  Glisser-déposer ou <span className="text-primary">parcourir</span>
                </p>
                <p className="text-xs text-muted-foreground mt-0.5">{SIZE_LABEL[type]}</p>
              </div>
            </>
          )}
        </div>
      )}

      {/* Fichier chargé */}
      {hasFile && (
        <div className="rounded-lg border border-border bg-muted/30 p-3 space-y-3">
          {/* Ligne info + actions */}
          <div className="flex items-center gap-2">
            <div className="w-8 h-8 rounded bg-primary/10 flex items-center justify-center shrink-0">
              {type === 'image'
                ? <ImageIcon className="w-4 h-4 text-primary" />
                : <Music className="w-4 h-4 text-primary" />}
            </div>
            <p className="flex-1 min-w-0 text-xs text-foreground truncate">{shortName}</p>
            <div className="flex items-center gap-1 shrink-0">
              {/* Prévisualiser */}
              <Button
                type="button"
                variant="ghost"
                size="icon"
                className="h-7 w-7"
                onClick={() => setShowPreview(p => !p)}
                title={showPreview ? 'Masquer' : 'Prévisualiser'}
              >
                <Eye className="w-3.5 h-3.5" />
              </Button>
              {/* Remplacer */}
              <Button
                type="button"
                variant="ghost"
                size="icon"
                className="h-7 w-7"
                onClick={() => inputRef.current?.click()}
                disabled={uploading}
                title="Remplacer"
              >
                {uploading
                  ? <Loader2 className="w-3.5 h-3.5 animate-spin" />
                  : <Upload className="w-3.5 h-3.5" />}
              </Button>
              {/* Supprimer */}
              <Button
                type="button"
                variant="ghost"
                size="icon"
                className="h-7 w-7 text-destructive hover:text-destructive"
                onClick={handleRemove}
                disabled={uploading}
                title="Supprimer"
              >
                <X className="w-3.5 h-3.5" />
              </Button>
            </div>
          </div>

          {/* Preview */}
          {showPreview && (
            <div className="pt-1">
              {type === 'image' && (
                <div className="rounded-md overflow-hidden border border-border bg-background max-h-40 flex items-center justify-center">
                  <img
                    src={value}
                    alt="Aperçu"
                    className="max-h-40 max-w-full object-contain"
                    onError={() => toast.error('Impossible de charger l\'aperçu.')}
                  />
                </div>
              )}
              {type === 'audio' && (
                // eslint-disable-next-line jsx-a11y/media-has-caption
                <audio
                  src={value}
                  controls
                  className="w-full h-9"
                  onError={() => toast.error('Impossible de lire le fichier audio.')}
                />
              )}
            </div>
          )}
        </div>
      )}

      {/* Input caché */}
      <input
        ref={inputRef}
        type="file"
        accept={ACCEPT[type]}
        className="hidden"
        onChange={handleInputChange}
      />
    </div>
  );
}

/** Squelette de chargement pour MediaUpload */
export function MediaUploadSkeleton({ className }: { className?: string }) {
  return <Skeleton className={cn('h-24 w-full bg-muted rounded-lg', className)} />;
}
