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
 * Déduplique strictement une liste de questions par :
 * 1. ID unique
 * 2. URL Audio (Compréhension Orale)
 * 3. Choix / Propositions textuelles (qui identifient une question répétée entre différents tests sous des numéros différents)
 * 4. Référence unique
 * 5. Texte / Énoncé complet (pour Compréhension Écrite ou questions sans audio)
 *
 * Garantit qu'un candidat ne pourra JAMAIS avoir deux fois la même question ou le même document sonore,
 * même si les questions proviennent de différentes séries/tests dans le pack importé.
 */
export function deduplicateQuestions<T extends Partial<Question>>(questions: T[]): T[] {
  const seenIds = new Set<string>();
  const seenAudios = new Set<string>();
  const seenRefs = new Set<string>();
  const seenTexts = new Set<string>();
  const seenChoices = new Set<string>();
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

    // 3. Déduplication par propositions / choix textuels (pour les questions répétées entre séries de tests)
    // Ne pas dédupliquer si les choix sont simplement ['A', 'B', 'C', 'D'] (ex: images Q1-Q4)
    if (q.choix && Array.isArray(q.choix) && q.choix.length > 0) {
      const firstText = (q.choix[0]?.texte || '').trim();
      const isSimpleABCD = firstText.length === 1 || ['A', 'B', 'C', 'D'].includes(firstText);
      if (!isSimpleABCD) {
        const choiceKey = q.choix
          .map(c => `${c.id}:${(c.texte || '').trim().toLowerCase()}`)
          .join('|');
        if (seenChoices.has(choiceKey)) continue;
        seenChoices.add(choiceKey);
      }
    }

    // 4. Déduplication par Référence exacte
    if (q.reference && typeof q.reference === 'string' && q.reference.trim().length > 0) {
      const cleanRef = q.reference.trim().toLowerCase();
      if (seenRefs.has(cleanRef)) continue;
      seenRefs.add(cleanRef);
    }

    // 5. Déduplication par Texte complet UNIQUEMENT pour les questions sans audio (Compréhension Écrite)
    // Ne PAS utiliser sur la CO car la consigne est générique ("Écoutez le document...")
    const hasAudio = !!(q.audio_url && typeof q.audio_url === 'string' && q.audio_url.trim().length > 0);
    if (!hasAudio && q.texte && typeof q.texte === 'string') {
      const cleanText = q.texte.trim().toLowerCase().replace(/\s+/g, ' ');
      if (cleanText.length > 30) {
        if (seenTexts.has(cleanText)) continue;
        seenTexts.add(cleanText);
      }
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

