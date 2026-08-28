const fs = require('fs');
const path = require('path');

const cePath = 'C:/Users/HP/Desktop/EDUDESK TCF/EDUDESK TCF/public/data/comprehension_ecrite_banque.json';
const coPath = 'C:/Users/HP/Desktop/EDUDESK TCF/EDUDESK TCF/public/data/comprehension_orale_banque.json';

const ceData = JSON.parse(fs.readFileSync(cePath, 'utf8'));
const coData = JSON.parse(fs.readFileSync(coPath, 'utf8'));

function escapeSql(str) {
  if (!str) return '';
  return String(str).replace(/'/g, "''");
}

function generateSQLFor(items, epreuve, filename) {
  let sql = `-- ==========================================================\n`;
  sql += `-- SEED QUESTIONS : ${items.length} ${epreuve.toUpperCase()} DANS LA TABLE QUESTIONS\n`;
  sql += `-- ==========================================================\n\n`;
  sql += `DELETE FROM public.questions WHERE epreuve = '${epreuve}';\n\n`;

  const rows = [];
  for (let idx = 0; idx < items.length; idx++) {
    const item = items[idx];
    const ref = item.id || item.reference;
    let choixList = [];
    if (Array.isArray(item.choix)) {
      choixList = item.choix;
    } else if (item.propositions && typeof item.propositions === 'object') {
      choixList = Object.entries(item.propositions).map(([key, val]) => ({
        id: key,
        texte: String(val || '')
      }));
    }

    let audioUrl = item.audio_url || item.audio || '';
    if (audioUrl && !audioUrl.startsWith('http') && !audioUrl.startsWith('/')) {
      audioUrl = `/media/${audioUrl}`;
    }

    let imageUrl = item.image_url || item.image || '';
    if (imageUrl && !imageUrl.startsWith('http') && !imageUrl.startsWith('/')) {
      imageUrl = `/media/${imageUrl}`;
    }

    let ordreNum = item.ordre || (idx % 39) + 1;
    if (ref && ref.includes('_Q')) {
      const parts = ref.split('_Q');
      if (parts[1] && !isNaN(parseInt(parts[1], 10))) {
        ordreNum = parseInt(parts[1], 10);
      }
    }

    const texte = item.texte || item.consigne || '';
    const choixJson = JSON.stringify(choixList);

    rows.push(`(
  '${epreuve}',
  '${escapeSql(ref)}',
  ${item.niveau ? `'${escapeSql(item.niveau)}'` : 'NULL'},
  '${escapeSql(texte)}',
  ${audioUrl ? `'${escapeSql(audioUrl)}'` : 'NULL'},
  ${imageUrl ? `'${escapeSql(imageUrl)}'` : 'NULL'},
  '${escapeSql(choixJson)}'::jsonb,
  '${escapeSql(item.bonne_reponse || 'A')}',
  ${item.explication ? `'${escapeSql(item.explication)}'` : 'NULL'},
  ${ordreNum},
  true
)`);
  }

  for (let i = 0; i < rows.length; i += 50) {
    const batch = rows.slice(i, i + 50);
    sql += `INSERT INTO public.questions (epreuve, reference, niveau, texte, audio_url, image_url, choix, bonne_reponse, explication, ordre, actif) VALUES\n` + batch.join(',\n') + `;\n\n`;
  }

  const dirs = [
    'C:/Users/HP/Desktop/EDUDESK TCF/EDUDESK TCF/supabase/migrations',
    'C:/Users/HP/Desktop/EDUDESK-TCF/EDUDESK-TCF/supabase/migrations'
  ];

  for (const dir of dirs) {
    if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
    fs.writeFileSync(path.join(dir, filename), sql, 'utf8');
  }

  console.log(`Generated ${filename} with ${rows.length} rows`);
}

generateSQLFor(ceData, 'comprehension_ecrit', '00031a_seed_questions_CE.sql');
generateSQLFor(coData, 'comprehension_oral', '00031b_seed_questions_CO.sql');
