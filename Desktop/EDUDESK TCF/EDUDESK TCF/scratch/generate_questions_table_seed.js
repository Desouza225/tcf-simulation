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

// 1. Script EE pour questions
let sqlEE = `-- ==========================================================\n`;
sqlEE += `-- SEED QUESTIONS : 967 EXPRESSION ÉCRITE DANS LA TABLE QUESTIONS\n`;
sqlEE += `-- ==========================================================\n\n`;
sqlEE += `DELETE FROM public.questions WHERE epreuve = 'expression_ecrite';\n\n`;

const eeRows = [];
for (const item of eeData) {
  let texte = '';
  if (item.tache_numero === 3) {
    texte = `${item.consigne || ''}\n\nDocument A :\n${item.document_a || ''}\n\nDocument B :\n${item.document_b || ''}`.trim();
  } else if (item.tache_numero === 2) {
    texte = `${item.tache_nom || 'Tâche 2 — Article'} (${item.nombre_mots_label || '120 à 150 mots'})\n\n${item.consigne || ''}`.trim();
  } else {
    texte = `${item.tache_nom || 'Tâche 1 — Message'} (${item.nombre_mots_label || '60 à 120 mots'})\n\n${item.consigne || ''}`.trim();
  }

  eeRows.push(`(
  'expression_ecrite',
  '${escapeSql(item.id)}',
  'tache_${item.tache_numero}',
  ${item.tache_numero},
  '${escapeSql(texte)}',
  true
)`);
}

for (let i = 0; i < eeRows.length; i += 50) {
  const batch = eeRows.slice(i, i + 50);
  sqlEE += `INSERT INTO public.questions (epreuve, reference, tache, ordre, texte, actif) VALUES\n` + batch.join(',\n') + `;\n\n`;
}

// 2. Script EO pour questions
let sqlEO = `-- ==========================================================\n`;
sqlEO += `-- SEED QUESTIONS : 509+ EXPRESSION ORALE DANS LA TABLE QUESTIONS\n`;
sqlEO += `-- ==========================================================\n\n`;
sqlEO += `DELETE FROM public.questions WHERE epreuve = 'expression_orale';\n\n`;

const eoRows = [];
const defaultEO1 = [
  { ref: 'EO_T1_001', texte: 'Tâche 1 — Entretien sans préparation (Durée : environ 2 minutes)\n\nPrésentez-vous, parlez de votre parcours professionnel ou universitaire, de vos motivations et de vos projets.' },
  { ref: 'EO_T1_002', texte: 'Tâche 1 — Entretien sans préparation (Durée : environ 2 minutes)\n\nParlez de votre expérience dans l\'apprentissage du français : vos méthodes, vos difficultés et vos plus grandes réussites.' },
  { ref: 'EO_T1_003', texte: 'Tâche 1 — Entretien sans préparation (Durée : environ 2 minutes)\n\nParlez de vos centres d\'intérêt, de vos loisirs et de la manière dont vous aimez passer votre temps libre.' },
  { ref: 'EO_T1_004', texte: 'Tâche 1 — Entretien sans préparation (Durée : environ 2 minutes)\n\nDécrivez votre ville ou région d\'origine : son climat, ses atouts, ses traditions et ce que vous y préférez.' }
];

for (const t1 of defaultEO1) {
  eoRows.push(`(
  'expression_orale',
  '${escapeSql(t1.ref)}',
  'tache_1',
  1,
  '${escapeSql(t1.texte)}',
  true
)`);
}

for (const item of eoData) {
  let texte = '';
  if (item.document_support) {
    texte = `${item.tache_nom || ''} (${item.duree_label || ''})\n\nSujet :\n${item.document_support}\n\nConsignes :\n${item.consigne || ''}`.trim();
  } else {
    texte = `${item.tache_nom || ''} (${item.duree_label || ''})\n\n${item.consigne || ''}`.trim();
  }

  eoRows.push(`(
  'expression_orale',
  '${escapeSql(item.id)}',
  'tache_${item.tache_numero}',
  ${item.tache_numero},
  '${escapeSql(texte)}',
  true
)`);
}

for (let i = 0; i < eoRows.length; i += 50) {
  const batch = eoRows.slice(i, i + 50);
  sqlEO += `INSERT INTO public.questions (epreuve, reference, tache, ordre, texte, actif) VALUES\n` + batch.join(',\n') + `;\n\n`;
}

const dirs = [
  'C:/Users/HP/Desktop/EDUDESK TCF/EDUDESK TCF/supabase/migrations',
  'C:/Users/HP/Desktop/EDUDESK-TCF/EDUDESK-TCF/supabase/migrations'
];

for (const dir of dirs) {
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
  fs.writeFileSync(path.join(dir, '00030a_seed_questions_EE.sql'), sqlEE, 'utf8');
  fs.writeFileSync(path.join(dir, '00030b_seed_questions_EO.sql'), sqlEO, 'utf8');
}

console.log('Successfully generated 00030a (EE) and 00030b (EO) for questions table!');
