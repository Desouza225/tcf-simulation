
-- Enum types
CREATE TYPE public.user_role AS ENUM ('super_admin', 'admin', 'professeur', 'etudiant');
CREATE TYPE public.epreuve_type AS ENUM ('comprehension_oral', 'comprehension_ecrit', 'expression_ecrite', 'expression_orale');
CREATE TYPE public.niveau_cecrl AS ENUM ('A1', 'A2', 'B1', 'B2', 'C1', 'C2');
CREATE TYPE public.mode_examen AS ENUM ('entrainement', 'examen_blanc');
CREATE TYPE public.statut_correction AS ENUM ('en_attente', 'en_cours', 'corrige');
CREATE TYPE public.statut_abonnement AS ENUM ('actif', 'expire', 'annule');
CREATE TYPE public.plan_abonnement AS ENUM ('basic', 'premium');
CREATE TYPE public.statut_paiement AS ENUM ('en_attente', 'confirme', 'echoue', 'rembourse');
CREATE TYPE public.methode_paiement AS ENUM ('cinetpay', 'stripe');

-- Profiles table (synced with auth.users)
CREATE TABLE public.profiles (
  id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email text UNIQUE,
  nom text,
  prenom text,
  role public.user_role NOT NULL DEFAULT 'etudiant',
  avatar_url text,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- Questions bank
CREATE TABLE public.questions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  epreuve public.epreuve_type NOT NULL,
  niveau public.niveau_cecrl,
  texte text,
  audio_url text,
  image_url text,
  choix jsonb, -- array of {id, texte}
  bonne_reponse text,
  explication text,
  ordre integer DEFAULT 0,
  actif boolean NOT NULL DEFAULT true,
  cree_par uuid REFERENCES public.profiles(id),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.questions ENABLE ROW LEVEL SECURITY;

-- Tâches expression écrite/orale (consignes)
CREATE TABLE public.taches (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  epreuve public.epreuve_type NOT NULL,
  numero_tache integer NOT NULL, -- 1, 2, 3 for écrite; 1, 3 for orale
  consigne text NOT NULL,
  duree_secondes integer, -- only for orale
  actif boolean NOT NULL DEFAULT true,
  cree_par uuid REFERENCES public.profiles(id),
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.taches ENABLE ROW LEVEL SECURITY;

-- Attributions professeur-étudiant
CREATE TABLE public.attributions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  professeur_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  etudiant_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  attribue_par uuid REFERENCES public.profiles(id),
  created_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (etudiant_id)
);

ALTER TABLE public.attributions ENABLE ROW LEVEL SECURITY;

-- Abonnements
CREATE TABLE public.abonnements (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  etudiant_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  plan public.plan_abonnement NOT NULL,
  statut public.statut_abonnement NOT NULL DEFAULT 'actif',
  date_debut timestamptz NOT NULL DEFAULT now(),
  date_fin timestamptz,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.abonnements ENABLE ROW LEVEL SECURITY;

-- Paiements
CREATE TABLE public.paiements (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  etudiant_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  abonnement_id uuid REFERENCES public.abonnements(id),
  montant numeric(10,2) NOT NULL,
  devise text NOT NULL DEFAULT 'XOF',
  methode public.methode_paiement NOT NULL,
  statut public.statut_paiement NOT NULL DEFAULT 'en_attente',
  transaction_id text,
  metadata jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.paiements ENABLE ROW LEVEL SECURITY;

-- Sessions d'examen (entraînement ou examen blanc)
CREATE TABLE public.sessions_examen (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  etudiant_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  mode public.mode_examen NOT NULL,
  epreuve_actuelle public.epreuve_type,
  statut text NOT NULL DEFAULT 'en_cours', -- en_cours, termine, abandonne
  score_oral integer,
  score_ecrit integer,
  score_expression_ecrite integer,
  score_expression_orale integer,
  score_global integer,
  niveau_cecrl public.niveau_cecrl,
  correction_complete boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now(),
  termine_at timestamptz
);

ALTER TABLE public.sessions_examen ENABLE ROW LEVEL SECURITY;

-- Réponses QCM
CREATE TABLE public.reponses_qcm (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id uuid NOT NULL REFERENCES public.sessions_examen(id) ON DELETE CASCADE,
  question_id uuid NOT NULL REFERENCES public.questions(id),
  reponse_choisie text,
  est_correcte boolean,
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.reponses_qcm ENABLE ROW LEVEL SECURITY;

-- Productions expression (écrite et orale)
CREATE TABLE public.productions (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  session_id uuid NOT NULL REFERENCES public.sessions_examen(id) ON DELETE CASCADE,
  etudiant_id uuid NOT NULL REFERENCES public.profiles(id),
  epreuve public.epreuve_type NOT NULL,
  numero_tache integer NOT NULL,
  contenu_texte text,
  audio_url text,
  statut_correction public.statut_correction NOT NULL DEFAULT 'en_attente',
  professeur_id uuid REFERENCES public.profiles(id),
  score integer,
  commentaire text,
  grille_notation jsonb,
  corrige_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.productions ENABLE ROW LEVEL SECURITY;

-- Notifications
CREATE TABLE public.notifications (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  utilisateur_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  titre text NOT NULL,
  message text NOT NULL,
  lue boolean NOT NULL DEFAULT false,
  lien text,
  created_at timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;

-- Trigger: sync new user to profiles
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER SET search_path = public
AS $$
BEGIN
  INSERT INTO public.profiles (id, email, role)
  VALUES (
    NEW.id,
    NEW.email,
    'etudiant'::public.user_role
  );
  RETURN NEW;
END;
$$;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.handle_new_user();

-- updated_at trigger function
CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;

CREATE TRIGGER set_profiles_updated_at BEFORE UPDATE ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();
CREATE TRIGGER set_abonnements_updated_at BEFORE UPDATE ON public.abonnements
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();
CREATE TRIGGER set_paiements_updated_at BEFORE UPDATE ON public.paiements
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();
