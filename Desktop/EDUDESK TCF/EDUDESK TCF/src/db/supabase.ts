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
 * Fetch all active questions for a given epreuve type.
 * Normalise le champ `choix` de chaque question avant retour.
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
  return rows.map(q => ({ ...q, choix: normalizeChoix(q.choix) })) as T[];
}
