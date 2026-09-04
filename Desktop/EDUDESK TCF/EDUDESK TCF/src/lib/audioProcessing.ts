import { supabase } from '@/db/supabase';

// Stockage local en cache pour une réactivité immédiate sans latence réseau
const LOCAL_STORAGE_KEY = 'edudesk_audio_clarity_enabled';

let cachedSetting: boolean | null = null;

/**
 * Récupère l'état global du réglage de clarté vocale.
 * Utilise le cache local immédiatement puis synchronise avec Supabase `parametres_globaux`.
 */
export async function getAudioClaritySetting(): Promise<boolean> {
  // 1. Valeur en mémoire si déjà chargée
  if (cachedSetting !== null) {
    return cachedSetting;
  }

  // 2. Valeur en localStorage si présente
  try {
    const local = localStorage.getItem(LOCAL_STORAGE_KEY);
    if (local !== null) {
      cachedSetting = local === 'true';
    }
  } catch {
    /* localStorage inaccessible */
  }

  // 3. Récupération depuis Supabase
  try {
    const { data, error } = await supabase
      .from('parametres_globaux')
      .select('valeur')
      .eq('cle', 'audio_clarity_enabled')
      .maybeSingle();

    if (!error && data && data.valeur !== undefined && data.valeur !== null) {
      const val = typeof data.valeur === 'boolean' ? data.valeur : data.valeur === 'true' || data.valeur === true;
      cachedSetting = val;
      try {
        localStorage.setItem(LOCAL_STORAGE_KEY, String(val));
      } catch { /* ignore */ }
      return val;
    }
  } catch (err) {
    console.warn('Erreur lecture parametres_globaux audio_clarity_enabled:', err);
  }

  // Par défaut : activé (true) pour garantir la clarté vocale
  if (cachedSetting === null) cachedSetting = true;
  return cachedSetting;
}

/**
 * Met à jour le paramètre global (réservé aux administrateurs).
 */
export async function setAudioClaritySetting(enabled: boolean): Promise<boolean> {
  cachedSetting = enabled;
  try {
    localStorage.setItem(LOCAL_STORAGE_KEY, String(enabled));
  } catch { /* ignore */ }

  try {
    const { error } = await supabase
      .from('parametres_globaux')
      .upsert({
        cle: 'audio_clarity_enabled',
        valeur: enabled,
        description: 'Active le traitement de clarté vocale et la normalisation dynamique du volume pour tous les candidats en Compréhension Orale',
        updated_at: new Date().toISOString(),
      });

    if (error) throw error;
    return true;
  } catch (err) {
    console.error('Erreur sauvegarde paramètre audio_clarity_enabled:', err);
    throw err;
  }
}

// ─── GESTIONNAIRE WEB AUDIO API EN TEMPS RÉEL ───────────────────────────────

interface AudioChain {
  ctx: AudioContext;
  source: MediaElementAudioSourceNode;
  highPass: BiquadFilterNode;
  midCut: BiquadFilterNode;
  presenceBoost: BiquadFilterNode;
  compressor: DynamicsCompressorNode;
  processedGain: GainNode;
  dryGain: GainNode;
}

// Map pour associer chaque élément HTMLAudioElement à son graphe audio Web Audio
const audioChains = new WeakMap<HTMLMediaElement, AudioChain>();

let sharedAudioContext: AudioContext | null = null;

function getOrCreateAudioContext(): AudioContext | null {
  if (typeof window === 'undefined') return null;
  const AudioCtx = window.AudioContext || (window as unknown as { webkitAudioContext: typeof AudioContext }).webkitAudioContext;
  if (!AudioCtx) return null;

  if (!sharedAudioContext || sharedAudioContext.state === 'closed') {
    sharedAudioContext = new AudioCtx();
  }
  if (sharedAudioContext.state === 'suspended') {
    sharedAudioContext.resume().catch(() => {});
  }
  return sharedAudioContext;
}

/**
 * Attache la chaîne de traitement de clarté vocale à un élément <audio>.
 * Si `isEnabled` est true :
 *   1. Filtre coupe-bas à 130 Hz (supprime la lourdeur et les basses sourdes)
 *   2. Filtre d'atténuation à 350 Hz (-2.5 dB, supprime l'effet "boîte/bocal")
 *   3. Boost de présence vocale à 3.2 kHz (+3.0 dB, clarifie l'articulation des consonnes)
 *   4. Compresseur dynamique (lisse les écarts de volume entre audios trop bas et trop forts)
 * Si `isEnabled` est false :
 *   Le son brut d'origine passe directement sans modification.
 */
export function attachAudioClarityProcessor(audioEl: HTMLMediaElement, isEnabled: boolean) {
  try {
    const ctx = getOrCreateAudioContext();
    if (!ctx) return;

    let chain = audioChains.get(audioEl);

    if (!chain) {
      // Créer la source Web Audio une seule fois par élément
      const source = ctx.createMediaElementSource(audioEl);

      // 1. Coupe-bas (High-Pass à 130 Hz, Q = 0.7)
      const highPass = ctx.createBiquadFilter();
      highPass.type = 'highpass';
      highPass.frequency.value = 130;
      highPass.Q.value = 0.7;

      // 2. Nettoyage du bas-médium (Peaking à 350 Hz, -2.5 dB, Q = 1.0)
      const midCut = ctx.createBiquadFilter();
      midCut.type = 'peaking';
      midCut.frequency.value = 350;
      midCut.gain.value = -2.5;
      midCut.Q.value = 1.0;

      // 3. Boost de présence vocale (Peaking à 3200 Hz, +3.0 dB, Q = 1.2)
      const presenceBoost = ctx.createBiquadFilter();
      presenceBoost.type = 'peaking';
      presenceBoost.frequency.value = 3200;
      presenceBoost.gain.value = 3.0;
      presenceBoost.Q.value = 1.2;

      // 4. Compresseur Dynamique (harmonisation du volume et nivellement)
      const compressor = ctx.createDynamicsCompressor();
      compressor.threshold.value = -22; // Déclenche à -22 dB
      compressor.knee.value = 12;
      compressor.ratio.value = 3.5;     // Compression modérée et naturelle
      compressor.attack.value = 0.003;  // 3 ms
      compressor.release.value = 0.25;  // 250 ms

      // 5. Nœuds de routage Wet / Dry
      const processedGain = ctx.createGain();
      const dryGain = ctx.createGain();

      // Chaîne traitée : source -> highPass -> midCut -> presenceBoost -> compressor -> processedGain -> destination
      source.connect(highPass);
      highPass.connect(midCut);
      midCut.connect(presenceBoost);
      presenceBoost.connect(compressor);
      compressor.connect(processedGain);
      processedGain.connect(ctx.destination);

      // Chaîne directe (dry) : source -> dryGain -> destination
      source.connect(dryGain);
      dryGain.connect(ctx.destination);

      chain = {
        ctx,
        source,
        highPass,
        midCut,
        presenceBoost,
        compressor,
        processedGain,
        dryGain,
      };

      audioChains.set(audioEl, chain);
    }

    // Basculer entre le son traité (Clarté active) et le son brut direct
    if (isEnabled) {
      chain.processedGain.gain.setValueAtTime(1.0, chain.ctx.currentTime);
      chain.dryGain.gain.setValueAtTime(0.0, chain.ctx.currentTime);
    } else {
      chain.processedGain.gain.setValueAtTime(0.0, chain.ctx.currentTime);
      chain.dryGain.gain.setValueAtTime(1.0, chain.ctx.currentTime);
    }
  } catch (err) {
    console.warn('Traitement Web Audio API non disponible:', err);
  }
}

/**
 * Résout une URL audio fiable pour la lecture dans le navigateur.
 * Tente d'abord de générer une URL signée Supabase (valable 2h) si le fichier est dans le bucket `productions-audio`.
 * Si l'URL directe échoue ou si le bucket est privé, télécharge le blob binaire avec le token d'authentification
 * et crée un `blob:http...` 100% garanti de fonctionner sans problème CORS ou de droits.
 */
export async function resolvePlayableAudioUrl(rawUrlOrPath: string): Promise<string> {
  if (!rawUrlOrPath || typeof rawUrlOrPath !== 'string') return '';
  const trimmed = rawUrlOrPath.trim();
  if (!trimmed) return '';

  // Si c'est déjà un Blob local ou data URL
  if (trimmed.startsWith('blob:') || trimmed.startsWith('data:')) {
    return trimmed;
  }

  // Extraire le chemin relatif si c'est une URL Supabase
  let storagePath = trimmed;
  if (trimmed.includes('/productions-audio/')) {
    const parts = trimmed.split('/productions-audio/');
    storagePath = parts[1]?.split('?')[0] || '';
  }

  // Si on a un chemin dans productions-audio
  if (storagePath && !storagePath.startsWith('http://') && !storagePath.startsWith('https://')) {
    try {
      // 1. Tenter URL signée (valable 2h)
      const { data: signedData, error: signedError } = await supabase.storage
        .from('productions-audio')
        .createSignedUrl(storagePath, 7200);

      if (!signedError && signedData?.signedUrl) {
        return signedData.signedUrl;
      }
    } catch (err) {
      console.warn('Erreur createSignedUrl:', err);
    }

    try {
      // 2. Tenter le téléchargement direct du blob avec le client Supabase
      const { data: blob, error: downloadError } = await supabase.storage
        .from('productions-audio')
        .download(storagePath);

      if (!downloadError && blob) {
        return URL.createObjectURL(blob);
      }
    } catch (err) {
      console.warn('Erreur download blob productions-audio:', err);
    }

    // 3. Fallback URL publique
    const { data: publicData } = supabase.storage
      .from('productions-audio')
      .getPublicUrl(storagePath);
    if (publicData?.publicUrl) {
      return publicData.publicUrl;
    }
  }

  return trimmed;
}

/**
 * Télécharge le fichier audio en mémoire et renvoie un ObjectURL local.
 * Utilisé comme secours infaillible si le tag <audio> déclenche une erreur.
 */
export async function fetchAudioBlobUrl(rawUrlOrPath: string): Promise<string | null> {
  if (!rawUrlOrPath) return null;
  let storagePath = rawUrlOrPath.trim();
  if (storagePath.includes('/productions-audio/')) {
    const parts = storagePath.split('/productions-audio/');
    storagePath = parts[1]?.split('?')[0] || '';
  }
  if (!storagePath || storagePath.startsWith('http')) {
    try {
      const res = await fetch(rawUrlOrPath);
      if (res.ok) {
        const blob = await res.blob();
        return URL.createObjectURL(blob);
      }
    } catch {
      return null;
    }
  }

  try {
    const { data: blob, error } = await supabase.storage
      .from('productions-audio')
      .download(storagePath);
    if (!error && blob) {
      return URL.createObjectURL(blob);
    }
  } catch (err) {
    console.error('Erreur fetchAudioBlobUrl:', err);
  }
  return null;
}
