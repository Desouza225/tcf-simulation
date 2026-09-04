export interface Option {
  label: string;
  value: string;
  icon?: React.ComponentType<{ className?: string }>;
  withCount?: boolean;
}

// Types principaux pour EDUDESK TCF

export type UserRole = 'super_admin' | 'admin' | 'professeur' | 'etudiant';
export type EpreuveType = 'comprehension_oral' | 'comprehension_ecrit' | 'expression_ecrite' | 'expression_orale';
export type NiveauCECRL = 'A1' | 'A2' | 'B1' | 'B2' | 'C1' | 'C2';
export type ModeExamen = 'entrainement' | 'examen_blanc';
export type StatutCorrection = 'en_attente' | 'en_cours' | 'corrige' | 'refuse';
export type StatutAbonnement = 'actif' | 'expire' | 'annule';
export type PlanAbonnement = 'basic' | 'premium';
export type StatutPaiement = 'en_attente' | 'confirme' | 'echoue' | 'rembourse';
export type MethodePaiement = 'cinetpay' | 'stripe';

export interface Profile {
  id: string;
  email: string | null;
  nom: string | null;
  prenom: string | null;
  role: UserRole;
  avatar_url: string | null;
  examen_blanc_actif: boolean;
  bloque: boolean;
  cree_par: string | null;
  last_active_at: string | null;
  current_session_token: string | null;
  created_at: string;
  updated_at: string;
}

export interface ChoixReponse {
  id: string;
  texte: string;
}

export interface Question {
  id: string;
  epreuve: EpreuveType;
  niveau: NiveauCECRL | null;
  reference?: string | null;
  texte: string | null;
  audio_url: string | null;
  image_url: string | null;
  choix: ChoixReponse[] | null;
  bonne_reponse: string | null;
  explication: string | null;
  ordre: number;
  actif: boolean;
  cree_par: string | null;
  created_at: string;
  updated_at: string;
}

export interface Tache {
  id: string;
  epreuve: EpreuveType;
  numero_tache: number;
  reference?: string | null;
  consigne: string;
  duree_secondes: number | null;
  actif: boolean;
  cree_par: string | null;
  created_at: string;
}

export interface Attribution {
  id: string;
  professeur_id: string;
  etudiant_id: string;
  attribue_par: string | null;
  created_at: string;
  professeur?: Profile;
  etudiant?: Profile;
}

export interface Abonnement {
  id: string;
  etudiant_id: string;
  plan: PlanAbonnement;
  statut: StatutAbonnement;
  date_debut: string;
  date_fin: string | null;
  created_at: string;
  updated_at: string;
}

export interface Paiement {
  id: string;
  etudiant_id: string;
  abonnement_id: string | null;
  montant: number;
  devise: string;
  methode: MethodePaiement;
  statut: StatutPaiement;
  transaction_id: string | null;
  metadata: Record<string, unknown> | null;
  created_at: string;
  updated_at: string;
}

export interface SessionExamen {
  id: string;
  etudiant_id: string;
  mode: ModeExamen;
  epreuve_actuelle: EpreuveType | null;
  statut: 'en_cours' | 'termine' | 'abandonne';
  score_oral: number | null;
  score_ecrit: number | null;
  score_expression_ecrite: number | null;
  score_expression_orale: number | null;
  score_global: number | null;
  niveau_cecrl: NiveauCECRL | null;
  correction_complete: boolean;
  duree_expression_ecrite: number | null;
  created_at: string;
  termine_at: string | null;
  etudiant?: Profile;
}

export interface ReponseQcm {
  id: string;
  session_id: string;
  question_id: string;
  reponse_choisie: string | null;
  est_correcte: boolean | null;
  created_at: string;
  question?: Question;
}

export interface Production {
  id: string;
  session_id: string;
  etudiant_id: string;
  epreuve: EpreuveType;
  numero_tache: number;
  reference?: string | null;
  contenu_texte: string | null;
  audio_url: string | null;
  statut_correction: StatutCorrection;
  professeur_id: string | null;
  score: number | null;
  commentaire: string | null;
  grille_notation: Record<string, number> | null;
  corrige_at: string | null;
  raison_refus: string | null;
  created_at: string;
  etudiant?: Profile;
  professeur?: Profile;
  session?: SessionExamen;
}

export interface Notification {
  id: string;
  utilisateur_id: string;
  titre: string;
  message: string;
  lue: boolean;
  lien: string | null;
  created_at: string;
}

export const PLANS = {
  basic: {
    nom: 'Basic',
    prix_xof: 5000,
    prix_eur: 8,
    description: 'Accès au mode entraînement uniquement',
    features: [
      'Mode entraînement illimité',
      'Toutes les 4 épreuves TCF Canada',
      'Correction immédiate pour les QCM',
      'Historique des exercices',
    ],
  },
  premium: {
    nom: 'Premium',
    prix_xof: 15000,
    prix_eur: 23,
    description: 'Accès complet à toutes les fonctionnalités',
    features: [
      'Tout le plan Basic',
      'Examens blancs illimités',
      'Correction par un professeur',
      'Score et niveau CECRL officiel',
      'Rapport détaillé par épreuve',
      'Graphiques de progression',
    ],
  },
} as const;

export const EPREUVE_LABELS: Record<EpreuveType, string> = {
  comprehension_oral: 'Compréhension Orale',
  comprehension_ecrit: 'Compréhension Écrite',
  expression_ecrite: 'Expression Écrite',
  expression_orale: 'Expression Orale',
};

export const EPREUVE_DUREES: Record<EpreuveType, number> = {
  comprehension_oral: 35 * 60,
  comprehension_ecrit: 60 * 60,
  expression_ecrite: 60 * 60,
  expression_orale: (2 + 4.5) * 60,
};

export const ROLE_LABELS: Record<UserRole, string> = {
  super_admin: 'Super Administrateur',
  admin: 'Administrateur',
  professeur: 'Professeur',
  etudiant: 'Étudiant',
};

export const CECRL_COLORS: Record<NiveauCECRL, string> = {
  A1: '#EF4444', // rouge — niveau débutant
  A2: '#F87171', // rouge clair — niveau élémentaire
  B1: '#F97316', // orange — niveau intermédiaire
  B2: '#FB923C', // orange clair — niveau indépendant
  C1: '#22C55E', // vert — niveau avancé
  C2: '#16A34A', // vert foncé — niveau maîtrise
};

/**
 * Convertit un pourcentage de réussite en niveau CECRL (barème TCF Canada).
 * < 17 % → A1 | 17–33 % → A2 | 34–49 % → B1 | 50–65 % → B2 | 66–82 % → C1 | > 82 % → C2
 */
export function pctToCECRL(pct: number): NiveauCECRL {
  if (pct < 17) return 'A1';
  if (pct < 34) return 'A2';
  if (pct < 50) return 'B1';
  if (pct < 66) return 'B2';
  if (pct < 83) return 'C1';
  return 'C2';
}

export const CECRL_DESCRIPTIONS: Record<NiveauCECRL, string> = {
  A1: 'Introductif',
  A2: 'Élémentaire',
  B1: 'Intermédiaire',
  B2: 'Indépendant',
  C1: 'Avancé',
  C2: 'Maîtrise',
};

export const NIVEAU_CECRL_LIST: NiveauCECRL[] = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

/**
 * Tableau de conversion officiel Expression Écrite TCF Canada (Score sur 20 -> Niveau CECRL)
 */
export const CONVERSION_CECRL_EXPRESSION_ECRITE = [
  { score_min: 0, score_max: 3, niveau_cecrl: 'A1' as const, label: 'A1' },
  { score_min: 4, score_max: 5, niveau_cecrl: 'A2' as const, label: 'A2' },
  { score_min: 6, score_max: 9, niveau_cecrl: 'B1' as const, label: 'B1' },
  { score_min: 10, score_max: 13, niveau_cecrl: 'B2' as const, label: 'B2' },
  { score_min: 14, score_max: 15, niveau_cecrl: 'C1' as const, label: 'C1' },
  { score_min: 16, score_max: 20, niveau_cecrl: 'C2' as const, label: 'C1-C2' },
];

export function scoreEeToCECRL(score: number): NiveauCECRL {
  if (score >= 16) return 'C2';
  if (score >= 14) return 'C1';
  if (score >= 10) return 'B2';
  if (score >= 6) return 'B1';
  if (score >= 4) return 'A2';
  return 'A1';
}

export function scoreEeToCECRLLabel(score: number): string {
  if (score >= 16) return 'C1-C2';
  if (score >= 14) return 'C1';
  if (score >= 10) return 'B2';
  if (score >= 6) return 'B1';
  if (score >= 4) return 'A2';
  return 'A1';
}
