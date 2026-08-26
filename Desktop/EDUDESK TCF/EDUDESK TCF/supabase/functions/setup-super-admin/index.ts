import { createClient } from 'npm:@supabase/supabase-js@2';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders });
  }

  try {
    // Utiliser le service role key pour l'API Admin
    const supabaseAdmin = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!,
      { auth: { autoRefreshToken: false, persistSession: false } }
    );

    const email = 'moralessedesouza@gmail.com';
    const password = 'Desouza123';

    // Vérifier si l'utilisateur existe déjà
    const { data: existingUsers } = await supabaseAdmin.auth.admin.listUsers();
    const existing = existingUsers?.users?.find(u => u.email === email);

    if (existing) {
      // Mettre à jour le profil si l'utilisateur existe déjà
      await supabaseAdmin.from('profiles').update({
        nom: 'De Souza',
        prenom: 'Morales',
        role: 'super_admin',
      }).eq('id', existing.id);

      return new Response(JSON.stringify({
        success: true,
        message: 'Super Admin déjà existant — profil mis à jour',
        userId: existing.id,
      }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      });
    }

    // Créer l'utilisateur via l'API Admin officielle
    const { data: newUser, error: createError } = await supabaseAdmin.auth.admin.createUser({
      email,
      password,
      email_confirm: true,
      user_metadata: { nom: 'De Souza', prenom: 'Morales' },
    });

    if (createError) {
      throw new Error(`Erreur création utilisateur: ${createError.message}`);
    }

    if (!newUser?.user?.id) {
      throw new Error('Aucun ID utilisateur retourné');
    }

    // Mettre à jour le profil avec le rôle super_admin
    const { error: profileError } = await supabaseAdmin
      .from('profiles')
      .update({
        nom: 'De Souza',
        prenom: 'Morales',
        role: 'super_admin',
      })
      .eq('id', newUser.user.id);

    if (profileError) {
      throw new Error(`Erreur mise à jour profil: ${profileError.message}`);
    }

    return new Response(JSON.stringify({
      success: true,
      message: 'Super Admin créé avec succès',
      userId: newUser.user.id,
      email: newUser.user.email,
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });

  } catch (err) {
    console.error('Erreur setup-super-admin:', err);
    return new Response(JSON.stringify({
      success: false,
      error: err instanceof Error ? err.message : String(err),
    }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});
