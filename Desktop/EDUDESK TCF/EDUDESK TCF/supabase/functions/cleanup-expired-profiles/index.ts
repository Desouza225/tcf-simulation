import { createClient } from 'npm:@supabase/supabase-js@2';

const SUPABASE_URL = Deno.env.get('SUPABASE_URL')!;
const SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;

// Planification quotidienne à 03h00 UTC
Deno.cron('cleanup-expired-profiles', '0 3 * * *', async () => {
  await runCleanup();
});

/**
 * Nettoie les fichiers audio du storage pour une liste d'IDs d'étudiants
 * avant que la suppression DB en cascade ne perde les références audio_url.
 */
async function deleteStorageForUsers(supabase: ReturnType<typeof createClient>, userIds: string[]): Promise<void> {
  if (userIds.length === 0) return;

  // Récupérer toutes les URLs audio des productions des étudiants à supprimer
  const { data: productions } = await supabase
    .from('productions')
    .select('audio_url')
    .in('etudiant_id', userIds)
    .not('audio_url', 'is', null);

  if (!Array.isArray(productions) || productions.length === 0) return;

  const storagePaths: string[] = [];
  for (const prod of productions) {
    if (!prod.audio_url) continue;
    try {
      const url = new URL(prod.audio_url);
      const marker = '/productions-audio/';
      const idx = url.pathname.indexOf(marker);
      if (idx !== -1) storagePaths.push(url.pathname.slice(idx + marker.length));
    } catch { /* URL invalide, ignorer */ }
  }

  if (storagePaths.length === 0) return;

  // Supprimer par lots de 100 (limite Supabase Storage)
  for (let i = 0; i < storagePaths.length; i += 100) {
    const batch = storagePaths.slice(i, i + 100);
    const { error } = await supabase.storage.from('productions-audio').remove(batch);
    if (error) console.error(`[cleanup] Storage batch ${i} erreur:`, error.message);
  }
  console.log(`[cleanup] ${storagePaths.length} fichier(s) audio supprimé(s) du storage`);
}

/**
 * Supprime les fichiers audio des sessions d'entraînement d'expression orale
 * corrigés depuis plus de 10 jours.
 * Les enregistrements sont supprimés du storage Supabase mais les scores
 * et commentaires du professeur sont conservés en base de données.
 */
async function cleanupExpiredTrainingAudio(supabase: ReturnType<typeof createClient>): Promise<void> {
  const tenDaysAgo = new Date(Date.now() - 10 * 24 * 60 * 60 * 1000).toISOString();

  // Récupérer les productions d'entraînement expression orale corrigées > 10 jours
  const { data: productions, error } = await supabase
    .from('productions')
    .select('id, audio_url, session:session_id!inner(mode)')
    .eq('epreuve', 'expression_orale')
    .eq('statut_correction', 'corrige')
    .not('audio_url', 'is', null)
    .lt('corrige_at', tenDaysAgo);

  if (error) {
    console.error('[cleanup-audio] Erreur requête productions:', error.message);
    return;
  }

  if (!Array.isArray(productions) || productions.length === 0) {
    console.log('[cleanup-audio] Aucun audio d\'entraînement expiré à supprimer.');
    return;
  }

  // Filtrer uniquement les sessions en mode entraînement
  const trainProductions = productions.filter(
    (p) => (p.session as { mode: string } | null)?.mode === 'entrainement'
  );

  if (trainProductions.length === 0) {
    console.log('[cleanup-audio] Aucun audio d\'entraînement expiré après filtrage.');
    return;
  }

  // Extraire les chemins storage
  const storagePaths: string[] = [];
  const productionIds: string[] = [];

  for (const prod of trainProductions) {
    if (!prod.audio_url) continue;
    productionIds.push(prod.id);
    try {
      const url = new URL(prod.audio_url);
      const marker = '/productions-audio/';
      const idx = url.pathname.indexOf(marker);
      if (idx !== -1) storagePaths.push(url.pathname.slice(idx + marker.length));
    } catch { /* URL invalide */ }
  }

  // Supprimer les fichiers du storage par lots de 100
  let deletedFiles = 0;
  for (let i = 0; i < storagePaths.length; i += 100) {
    const batch = storagePaths.slice(i, i + 100);
    const { error: storageErr } = await supabase.storage.from('productions-audio').remove(batch);
    if (storageErr) {
      console.error(`[cleanup-audio] Batch ${i} erreur storage:`, storageErr.message);
    } else {
      deletedFiles += batch.length;
    }
  }

  // Mettre audio_url = NULL en base (score et commentaire conservés)
  if (productionIds.length > 0) {
    const { error: updateErr } = await supabase
      .from('productions')
      .update({ audio_url: null })
      .in('id', productionIds);
    if (updateErr) {
      console.error('[cleanup-audio] Erreur mise à jour audio_url:', updateErr.message);
    }
  }

  console.log(`[cleanup-audio] ${deletedFiles} fichier(s) audio supprimé(s), audio_url remis à NULL pour ${productionIds.length} production(s).`);
}

async function runCleanup(): Promise<{ deleted_count: number; executed_at: string; raisons: Record<string, number> }> {
  const supabase = createClient(SUPABASE_URL, SERVICE_ROLE_KEY, {
    auth: { persistSession: false },
  });

  // Identifier les étudiants qui seront supprimés (dry_run: true pour lister sans supprimer)
  const { data: dryRunData, error: dryRunError } = await supabase.rpc('cleanup_expired_profiles', { dry_run: true });
  if (dryRunError) {
    console.error('[cleanup] Erreur dry_run:', dryRunError.message);
    throw dryRunError;
  }

  // Extraire les user_ids des profils à supprimer
  const toDelete: string[] = Array.isArray(dryRunData?.profiles)
    ? dryRunData.profiles.map((p: { id: string }) => p.id)
    : [];

  // Supprimer les fichiers audio AVANT la suppression DB
  await deleteStorageForUsers(supabase, toDelete);

  // Appel de la fonction SQL SECURITY DEFINER — dry_run: false = suppression réelle
  const { data, error } = await supabase.rpc('cleanup_expired_profiles', { dry_run: false });

  if (error) {
    console.error('[cleanup] Erreur RPC:', error.message);
    throw error;
  }

  // Nettoyer les audios des sessions d'entraînement corrigés depuis > 10 jours
  await cleanupExpiredTrainingAudio(supabase);

  console.log('[cleanup] Résultat:', JSON.stringify(data));
  return data as { deleted_count: number; executed_at: string; raisons: Record<string, number> };
}

// Handler HTTP (pour déclenchement manuel ou webhook)
Deno.serve(async (req) => {
  // Sécurité : vérifier le secret d'autorisation
  const authHeader = req.headers.get('Authorization');
  const expectedSecret = Deno.env.get('CLEANUP_SECRET');

  if (expectedSecret && authHeader !== `Bearer ${expectedSecret}`) {
    return new Response(JSON.stringify({ error: 'Non autorisé' }), {
      status: 401,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  try {
    const result = await runCleanup();
    return new Response(JSON.stringify(result), {
      status: 200,
      headers: { 'Content-Type': 'application/json' },
    });
  } catch (err) {
    const message = err instanceof Error ? err.message : String(err);
    return new Response(JSON.stringify({ error: message }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' },
    });
  }
});
