import { createClient } from "@supabase/supabase-js";
import type { ChoixReponse, Question } from "@/types/index";

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

/**
 * Normalise le champ `choix` d'une question.
 * La base stocke un objet JSONB {"A":"texte","B":"texte",...}
 * mais le frontend attend un tableau [{id:"A",texte:"texte"},...]
 */
function normalizeChoix(raw: unknown): ChoixReponse[] | null {
  if (!raw) return null;
  // Déjà un tableau correctement formé
  if (Array.isArray(raw)) {
    if (raw.length > 0 && typeof raw[0] === 'object' && 'id' in raw[0]) {
      return raw as ChoixReponse[];
    }
  }
  // Objet JSONB {"A":"texte","B":"texte",...}
  if (typeof raw === 'object' && !Array.isArray(raw)) {
    return Object.entries(raw as Record<string, string>).map(([id, texte]) => ({ id, texte }));
  }
  return null;
}

/**
 * Déduplique strictement une liste de questions par ID, Audio URL, Référence et Contenu.
 * Garantit qu'un candidat ne pourra JAMAIS avoir la même question ou le même audio dans une session.
 */
export function deduplicateQuestions<T extends Partial<Question>>(questions: T[]): T[] {
  const seenIds = new Set<string>();
  const seenAudios = new Set<string>();
  const seenRefs = new Set<string>();
  const seenContents = new Set<string>();
  const result: T[] = [];

  for (const q of questions) {
    if (!q) continue;

    // 1. Déduplication par ID unique
    if (q.id) {
      if (seenIds.has(q.id)) continue;
      seenIds.add(q.id);
    }

    // 2. Déduplication stricte par Audio URL (Compréhension Orale)
    if (q.audio_url && typeof q.audio_url === 'string' && q.audio_url.trim().length > 0) {
      const cleanAudio = q.audio_url.trim().toLowerCase();
      if (seenAudios.has(cleanAudio)) continue;
      seenAudios.add(cleanAudio);
    }

    // 3. Déduplication par Référence
    if (q.reference && typeof q.reference === 'string' && q.reference.trim().length > 0) {
      const cleanRef = q.reference.trim().toLowerCase();
      if (seenRefs.has(cleanRef)) continue;
      seenRefs.add(cleanRef);
    }

    // 4. Déduplication par Contenu texte + choix (pour questions sans audio ou CE)
    if (q.texte && typeof q.texte === 'string' && q.texte.trim().length > 15) {
      const cleanContent = (q.texte.trim().toLowerCase() + '::' + JSON.stringify(q.choix || '')).replace(/\s+/g, ' ');
      if (seenContents.has(cleanContent)) continue;
      seenContents.add(cleanContent);
    }

    result.push(q);
  }

  return result;
}

/**
 * Fetch all active questions for a given epreuve type.
 * Normalise le champ `choix` et déduplique automatiquement chaque question avant retour.
 */
export async function fetchAllQuestions<T = Question>(epreuve: string): Promise<T[]> {
  const { data, error } = await supabase
    .from('questions')
    .select('*')
    .eq('epreuve', epreuve)
    .eq('actif', true)
    .order('ordre', { ascending: true });

  if (error) throw new Error(error.message);
  const rows = (data ?? []) as Question[];
  const normalized = rows.map(q => ({ ...q, choix: normalizeChoix(q.choix) }));
  return deduplicateQuestions(normalized) as unknown as T[];
}

