import { createClient } from 'npm:@supabase/supabase-js@2';
import { corsHeaders } from '../_shared/cors.ts';

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    const authHeader = req.headers.get('Authorization');
    if (!authHeader) {
      return new Response(JSON.stringify({ error: 'Non autorisé' }), {
        status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const supabaseAdmin = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '',
      { auth: { autoRefreshToken: false, persistSession: false } }
    );

    // Vérifier que l'appelant est admin ou super_admin
    const supabaseUser = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? '',
      { global: { headers: { Authorization: authHeader } } }
    );
    const { data: { user: caller } } = await supabaseUser.auth.getUser();
    if (!caller) {
      return new Response(JSON.stringify({ error: 'Utilisateur non authentifié' }), {
        status: 401, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const { data: callerProfile } = await supabaseAdmin
      .from('profiles')
      .select('role')
      .eq('id', caller.id)
      .maybeSingle();

    if (!callerProfile || !['admin', 'super_admin'].includes(callerProfile.role)) {
      return new Response(JSON.stringify({ error: 'Accès refusé.' }), {
        status: 403, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    const { userId } = await req.json();
    if (!userId) {
      return new Response(JSON.stringify({ error: 'userId requis.' }), {
        status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Empêcher la suppression d'un super_admin
    const { data: targetProfile } = await supabaseAdmin
      .from('profiles')
      .select('role')
      .eq('id', userId)
      .maybeSingle();

    if (targetProfile?.role === 'super_admin') {
      return new Response(JSON.stringify({ error: 'Impossible de supprimer un Super Administrateur.' }), {
        status: 403, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Empêcher un admin de supprimer un autre admin
    if (callerProfile.role === 'admin' && targetProfile?.role === 'admin') {
      return new Response(JSON.stringify({ error: 'Un admin ne peut pas supprimer un autre admin.' }), {
        status: 403, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Supprimer les fichiers audio dans le storage productions-audio
    // avant de supprimer l'utilisateur (la suppression DB cascade les enregistrements
    // mais ne nettoie pas le storage Supabase)
    const { data: productions } = await supabaseAdmin
      .from('productions')
      .select('audio_url')
      .eq('etudiant_id', userId)
      .not('audio_url', 'is', null);

    if (Array.isArray(productions) && productions.length > 0) {
      const storagePaths: string[] = [];
      for (const prod of productions) {
        if (!prod.audio_url) continue;
        try {
          // Extraire le chemin relatif depuis l'URL publique
          // Format : .../storage/v1/object/public/productions-audio/audio/<user_id>/...
          const url = new URL(prod.audio_url);
          const marker = '/productions-audio/';
          const idx = url.pathname.indexOf(marker);
          if (idx !== -1) {
            storagePaths.push(url.pathname.slice(idx + marker.length));
          }
        } catch {
          // URL invalide — ignorer
        }
      }
      if (storagePaths.length > 0) {
        const { error: storageError } = await supabaseAdmin.storage
          .from('productions-audio')
          .remove(storagePaths);
        if (storageError) {
          console.error('Erreur suppression storage:', storageError.message);
          // Non bloquant : continuer la suppression du compte
        }
      }
    }

    // Supprimer l'utilisateur (cascade SQL supprime automatiquement :
    // sessions_examen, reponses_qcm, productions, abonnements, notifications, attributions)
    const { error: deleteError } = await supabaseAdmin.auth.admin.deleteUser(userId);
    if (deleteError) {
      return new Response(JSON.stringify({ error: deleteError.message }), {
        status: 400, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    return new Response(JSON.stringify({ success: true }), {
      status: 200, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });

  } catch (error) {
    return new Response(JSON.stringify({ error: (error as Error).message }), {
      status: 500, headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});
