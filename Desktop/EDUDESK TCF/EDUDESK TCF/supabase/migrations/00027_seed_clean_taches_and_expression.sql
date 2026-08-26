-- Migration 00027: Réinitialiser et insérer des sujets propres et authentiques pour les Tâches d'Expression Écrite et Orale TCF Canada

-- 1. Nettoyer les anciennes tâches incomplètes
DELETE FROM public.taches WHERE epreuve IN ('expression_ecrite', 'expression_orale');

-- 2. Insérer les vrais sujets authentiques d'Expression Écrite
INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
-- Tâche 1 (Courriel / message informel)
(
  'expression_ecrite',
  1,
  'EE_T1_001',
  'Vous venez d''emménager dans une nouvelle ville au Canada. Rédigez un courriel à un ami pour lui présenter votre nouveau logement, votre quartier, les transports disponibles et ce que vous appréciez dans votre nouvel environnement. (Environ 60 à 120 mots)',
  NULL,
  true
),
(
  'expression_ecrite',
  1,
  'EE_T1_002',
  'Vous invitez des amis ou collègues à une fête pour célébrer votre nouvel emploi. Rédigez un message pour leur donner la date, le lieu, expliquer le déroulement de la soirée et demander à chacun de confirmer sa présence. (Environ 60 à 120 mots)',
  NULL,
  true
),

-- Tâche 2 (Article / lettre de compte-rendu)
(
  'expression_ecrite',
  2,
  'EE_T2_001',
  'Vous avez récemment participé à un événement culturel ou associatif dans votre ville (festival, journée sportive, salon). Rédigez un article pour le blog de votre quartier dans lequel vous racontez votre expérience, décrivez l''ambiance et expliquez pourquoi vous recommandez cet événement. (Environ 120 à 150 mots)',
  NULL,
  true
),
(
  'expression_ecrite',
  2,
  'EE_T2_002',
  'Vous avez fait appel à une entreprise de déménagement ou de services et vous avez rencontré un problème. Rédigez un courriel formel au service client pour expliquer la situation, exprimer votre mécontentement et demander un dédommagement ou une solution. (Environ 120 à 150 mots)',
  NULL,
  true
),

-- Tâche 3 (Synthèse de deux documents d'opinion + prise de position argumentée)
(
  'expression_ecrite',
  3,
  'EE_T3_001',
  'Vous devez rédiger un texte pour donner votre opinion argumentée sur le sujet ci-dessous.
Votre texte comportera deux parties :
1. Dans la première partie, vous dégagerez le problème commun présenté par les deux documents et présenterez les opinions exprimées dans chacun d''eux (synthèse brève et neutre).
2. Dans la seconde partie, vous prendrez position sur le sujet en donnant votre avis personnel argumenté avec des exemples précis.
(Nombre de mots attendu : 120 à 180 mots)

Document 1 — Le télétravail : un gain d''autonomie et de bien-être
« Le travail à distance permet d''éviter les trajets quotidiens épuisants, d''offrir une meilleure flexibilité horaire et d''améliorer l''équilibre entre la vie professionnelle et la vie privée. Il favorise l''autonomie et la productivité des salariés. » (P. Martin, DRH)

Document 2 — Les dérives du télétravail : isolement et fatigue
« Le télétravail isole les salariés, affaiblit la cohésion des équipes et rend floues les limites entre travail et repos. Cette hyperconnexion conduit fréquemment à un surmenage et à une perte de sens au travail. » (C. Dubois, sociologue)',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_002',
  'Vous devez rédiger un texte pour donner votre opinion argumentée sur le sujet ci-dessous.
Votre texte comportera deux parties :
1. Dans la première partie, vous dégagerez le problème commun présenté par les deux documents et présenterez les opinions exprimées dans chacun d''eux.
2. Dans la seconde partie, vous prendrez position sur le sujet en donnant votre avis personnel argumenté avec des exemples précis.
(Nombre de mots attendu : 120 à 180 mots)

Document 1 — Les cours universitaires 100 % en ligne : l''avenir de l''éducation
« L''enseignement à distance démocratise l''accès au savoir en permettant à chacun d''étudier à son propre rythme, où qu''il soit, tout en réduisant considérablement les frais de déplacement et de logement pour les étudiants. » (A. Tremblay, enseignant universitaire)

Document 2 — L''université en présentiel : indispensable à l''apprentissage
« L''apprentissage ne se résume pas à regarder des vidéos. Rien ne remplace les échanges spontanés en classe, les travaux de groupe et la vie de campus qui développent l''esprit critique et la socialisation des jeunes. » (E. Bernard, chercheuse en sciences de l''éducation)',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_003',
  'Vous devez rédiger un texte pour donner votre opinion argumentée sur le sujet ci-dessous.
Votre texte comportera deux parties :
1. Dans la première partie, vous dégagerez le problème commun présenté par les deux documents et présenterez les opinions exprimées dans chacun d''eux.
2. Dans la seconde partie, vous prendrez position sur le sujet en donnant votre avis personnel argumenté avec des exemples précis.
(Nombre de mots attendu : 120 à 180 mots)

Document 1 — L''intelligence artificielle : un levier d''efficacité sans précédent
« L''intelligence artificielle libère les humains des tâches répétitives et rébarbatives, augmente la créativité et permet d''accomplir en quelques minutes un travail qui prenait auparavant des jours. C''est une révolution positive. » (Y. Moreau, expert en technologies)

Document 2 — Les risques de l''IA : perte de compétences et dépendance
« À force de déléguer la réflexion, la rédaction et l''analyse aux algorithmes, les individus risquent de perdre leurs compétences critiques fondamentales et de devenir dépendants d''outils dont ils ne maîtrisent pas le fonctionnement. » (M. Lambert, philosophe des sciences)',
  NULL,
  true
);

-- 3. Insérer les vrais sujets authentiques d'Expression Orale
INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
(
  'expression_orale',
  1,
  'EO_T1_001',
  'Parlez de votre parcours professionnel ou de vos études. Quelles ont été les étapes importantes de votre parcours ? Pourquoi avez-vous choisi cette voie ? Donnez des exemples précis de vos expériences.',
  120,
  true
),
(
  'expression_orale',
  1,
  'EO_T1_002',
  'Parlez de votre expérience dans l''apprentissage du français. Quelles méthodes utilisez-vous ? Quelles sont vos difficultés et vos plus grands succès ? Donnez des exemples précis de votre apprentissage.',
  120,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_001',
  'Certaines personnes préfèrent vivre dans de grandes métropoles (comme Montréal ou Toronto) pour les opportunités professionnelles et culturelles, tandis que d''autres choisissent les villes moyennes ou la campagne pour la qualité de vie et le calme.
Présentez les avantages et les inconvénients de ces deux modes de vie et donnez votre avis personnel argumenté en vous appuyant sur des exemples concrets tirés de la réalité canadienne ou de votre expérience personnelle.',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_002',
  'Pensez-vous que les réseaux sociaux favorisent la communication et le rapprochement entre les gens ou, au contraire, qu''ils augmentent la solitude et l''isolement des individus ?
Développez votre argumentation en donnant des exemples précis tirés de votre expérience ou de l''actualité.',
  270,
  true
);
