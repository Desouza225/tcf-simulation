import { createClient } from 'npm:@supabase/supabase-js@2';

const SUPABASE_URL = Deno.env.get('SUPABASE_URL')!;
const SERVICE_ROLE_KEY = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;
const RESEND_API_KEY = Deno.env.get('RESEND_API_KEY')!;

// Planification quotidienne à 02h00 UTC (1h avant le nettoyage réel)
Deno.cron('warn-expiring-profiles', '0 2 * * *', async () => {
  await runWarnings();
});

interface ExpiringProfile {
  id: string;
  email: string | null;
  prenom: string | null;
  nom: string | null;
  role: string;
  created_at: string;
  last_active_at: string | null;
  raison: string;
}

async function runWarnings(): Promise<{ warned_count: number; executed_at: string }> {
  const supabase = createClient(SUPABASE_URL, SERVICE_ROLE_KEY, {
    auth: { persistSession: false },
  });

  // Identifier les profils qui seront supprimés dans exactement 7 jours
  const { data: expiring, error } = await supabase
    .from('profiles')
    .select('id, email, prenom, nom, role, created_at, last_active_at')
    .or(
      // Expiration 1 an : created_at dans exactement 7 jours (entre J+6 et J+7)
      `and(role.eq.etudiant,created_at.gte.${new Date(Date.now() - (365 - 7 + 1) * 86400_000).toISOString()},created_at.lte.${new Date(Date.now() - (365 - 7) * 86400_000).toISOString()}),` +
      // Inactivité étudiant (5 mois) : last_active_at dans exactement J-7 par rapport à la limite
      `and(role.eq.etudiant,last_active_at.gte.${new Date(Date.now() - (150 - 7 + 1) * 86400_000).toISOString()},last_active_at.lte.${new Date(Date.now() - (150 - 7) * 86400_000).toISOString()}),` +
      // Inactivité professeur (3 mois) : last_active_at
      `and(role.eq.professeur,last_active_at.gte.${new Date(Date.now() - (90 - 7 + 1) * 86400_000).toISOString()},last_active_at.lte.${new Date(Date.now() - (90 - 7) * 86400_000).toISOString()})`
    );

  if (error) {
    console.error('[warn-expiring] Erreur requête profils:', error.message);
    throw error;
  }

  const profiles: ExpiringProfile[] = (expiring ?? []).map((p: ExpiringProfile) => ({
    ...p,
    raison: p.role === 'professeur' ? 'inactivite_professeur'
      : p.created_at < new Date(Date.now() - (365 - 7) * 86400_000).toISOString()
        ? 'expiration_1_an'
        : 'inactivite_etudiant',
  }));

  let warnedCount = 0;

  for (const profile of profiles) {
    if (!profile.email) continue;

    const prenom = profile.prenom || 'Utilisateur';
    const html = `
      <div style="font-family: sans-serif; max-width: 560px; margin: 0 auto; padding: 24px;">
        <h2 style="color: #1a1a1a;">⚠️ Votre compte EDUDESK sera supprimé dans 7 jours</h2>
        <p style="color: #444;">Bonjour <strong>${prenom}</strong>,</p>
        <p style="color: #444;">
          Votre compte EDUDESK sera supprimé dans <strong>7 jours</strong> en raison d'une inactivité prolongée.
          Pour conserver votre compte et toutes vos données, connectez-vous simplement à la plateforme avant cette date.
        </p>
        <div style="margin: 32px 0; text-align: center;">
          <a href="${SUPABASE_URL.replace('https://', 'https://app.')}"
             style="background: #2563eb; color: white; padding: 12px 28px; border-radius: 8px; text-decoration: none; font-weight: 600;">
            Me connecter maintenant
          </a>
        </div>
        <p style="color: #888; font-size: 13px;">
          Si vous ne souhaitez pas conserver votre compte, vous n'avez rien à faire.<br>
          Cet email a été envoyé automatiquement par la plateforme EDUDESK TCF Canada.
        </p>
      </div>
    `;

    const res = await fetch('https://api.resend.com/emails', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${RESEND_API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        from: 'EDUDESK <noreply@edudesk.com>',
        to: profile.email,
        subject: 'Votre compte EDUDESK sera supprimé dans 7 jours',
        html,
      }),
    });

    if (res.ok) {
      warnedCount++;
      console.log(`[warn-expiring] Email envoyé à ${profile.email}`);
    } else {
      const errText = await res.text();
      console.error(`[warn-expiring] Échec envoi à ${profile.email}:`, errText);
    }
  }

  console.log(`[warn-expiring] ${warnedCount} email(s) envoyé(s)`);
  return { warned_count: warnedCount, executed_at: new Date().toISOString() };
}

// Handler HTTP (déclenchement manuel ou webhook cron externe)
Deno.serve(async (req) => {
  const authHeader = req.headers.get('Authorization');
  const expectedSecret = Deno.env.get('CLEANUP_SECRET');

  if (expectedSecret && authHeader !== `Bearer ${expectedSecret}`) {
    return new Response(JSON.stringify({ error: 'Non autorisé' }), {
      status: 401,
      headers: { 'Content-Type': 'application/json' },
    });
  }

  try {
    const result = await runWarnings();
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
