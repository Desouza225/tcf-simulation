const fs = require('fs');
const path = require('path');

const eePath = 'C:/Users/HP/Desktop/EDUDESK-TCF/967 expression_ecrite_PN_1787291411906/expression_ecrite_banque.json';
const eoPath = 'C:/Users/HP/Desktop/EDUDESK-TCF/509 expression_orale_pack_1787339531640/expression_orale_banque.json';

const eeData = JSON.parse(fs.readFileSync(eePath, 'utf8'));
const eoData = JSON.parse(fs.readFileSync(eoPath, 'utf8'));

function escapeSql(str) {
  if (!str) return '';
  return str.replace(/'/g, "''");
}

function generateForTache(num) {
  const items = eeData.filter(x => x.tache_numero === num);
  let sql = `-- ==========================================================\n`;
  sql += `-- SEED : TÂCHE ${num} EXPRESSION ÉCRITE (${items.length} sujets authentiques)\n`;
  sql += `-- ==========================================================\n\n`;
  sql += `DELETE FROM public.taches WHERE epreuve = 'expression_ecrite' AND numero_tache = ${num};\n\n`;

  const rows = [];
  for (const item of items) {
    let consigne = '';
    if (num === 3) {
      consigne = `${item.consigne || ''}\n\nDocument A :\n${item.document_a || ''}\n\nDocument B :\n${item.document_b || ''}`.trim();
    } else if (num === 2) {
      consigne = `${item.tache_nom || 'Tâche 2 — Article'} (${item.nombre_mots_label || '120 à 150 mots'})\n\n${item.consigne || ''}`.trim();
    } else {
      consigne = `${item.tache_nom || 'Tâche 1 — Message'} (${item.nombre_mots_label || '60 à 120 mots'})\n\n${item.consigne || ''}`.trim();
    }
    rows.push(`(\n  'expression_ecrite',\n  ${num},\n  '${escapeSql(item.id)}',\n  '${escapeSql(consigne)}',\n  NULL,\n  true\n)`);
  }

  for (let i = 0; i < rows.length; i += 50) {
    const batch = rows.slice(i, i + 50);
    sql += `INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES\n` + batch.join(',\n') + `;\n\n`;
  }

  return sql;
}

const sql1 = generateForTache(1);
const sql2 = generateForTache(2);
const sql3 = generateForTache(3);

const dirs = [
  'C:/Users/HP/Desktop/EDUDESK TCF/EDUDESK TCF/supabase/migrations',
  'C:/Users/HP/Desktop/EDUDESK-TCF/EDUDESK-TCF/supabase/migrations'
];

for (const dir of dirs) {
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
  fs.writeFileSync(path.join(dir, '00028a_seed_EE_Tache_1.sql'), sql1, 'utf8');
  fs.writeFileSync(path.join(dir, '00028b_seed_EE_Tache_2.sql'), sql2, 'utf8');
  fs.writeFileSync(path.join(dir, '00028c_seed_EE_Tache_3.sql'), sql3, 'utf8');
}

console.log('Successfully generated split seeds for Tâche 1 (306), Tâche 2 (311), and Tâche 3 (350)!');
