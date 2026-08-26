-- ==========================================================
-- SEED COMPLET : 509+ SUJETS AUTHENTIQUES EXPRESSION ORALE
-- Source : C:/Users/HP/Desktop/EDUDESK-TCF/509 expression_orale_pack_1787339531640/expression_orale_banque.json
-- ==========================================================

DELETE FROM public.taches WHERE epreuve = 'expression_orale';

INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
(
  'expression_orale',
  1,
  'EO_T1_001',
  'Tâche 1 — Entretien sans préparation (Durée : environ 2 minutes)

Présentez-vous, parlez de votre parcours professionnel ou universitaire, de vos motivations et de vos projets.',
  120,
  true
),
(
  'expression_orale',
  1,
  'EO_T1_002',
  'Tâche 1 — Entretien sans préparation (Durée : environ 2 minutes)

Parlez de votre expérience dans l''apprentissage du français : vos méthodes, vos difficultés et vos plus grandes réussites.',
  120,
  true
),
(
  'expression_orale',
  1,
  'EO_T1_003',
  'Tâche 1 — Entretien sans préparation (Durée : environ 2 minutes)

Parlez de vos centres d''intérêt, de vos loisirs et de la manière dont vous aimez passer votre temps libre.',
  120,
  true
),
(
  'expression_orale',
  1,
  'EO_T1_004',
  'Tâche 1 — Entretien sans préparation (Durée : environ 2 minutes)

Décrivez votre ville ou région d''origine : son climat, ses atouts, ses traditions et ce que vous y préférez.',
  120,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_001',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Vous voulez faire goûter des spécialités québécoises à des amis. Vous me demandez des idées pour préparer ce repas (endroit, menu, coût, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_002',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Je connais quelqu’un qui enseigne la cuisine. Vous souhaitez en savoir plus et vous me demandez des renseignements sur cette personne (compétences, horaires, prix, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_003',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Vous êtes arrivé(e) récemment au Québec. Vous me demandez des idées pour organiser une activité culturelle à petit budget (endroits, activités, moyens de transport, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_004',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) colocataire. J’ai prévu d’inviter quelques amis chez nous. Vous me demandez des renseignements sur cette visite (nombre d’invités, durée, ambiance, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_005',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Je prépare une soirée entre les habitants de l’immeuble et je vous propose d’y participer. Vous me demandez des renseignements sur l’événement (date, invités, repas, boissons, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_006',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) collègue. J’organise souvent des sorties de jogging en groupe. Vous souhaitez y participer et vous me posez des questions pour obtenir des informations (itinéraire, horaires, équipement, niveau, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_007',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) au service des activités de votre nouvelle ville. Vous cherchez une activité pour faire de nouvelles connaissances. Vous me posez des questions afin d’obtenir des renseignements (type d’activité, horaires, participants, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_008',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans un restaurant. Vous envisagez d’y organiser une fête d’anniversaire familiale. Vous me posez des questions pour obtenir des renseignements (capacité d’accueil, menus proposés, tarifs, modalités de réservation, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_009',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans un magasin de téléphones. Vous cherchez un premier smartphone pour un enfant. Vous me posez des questions afin d’obtenir des informations sur les produits disponibles (appareils, accessoires, prix, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_010',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) à l’accueil d’un parc de divertissement. Vous souhaitez y passer une journée et vous me posez des questions pour vous renseigner (tarifs, heures d’ouverture, activités, services, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_011',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre ami(e). Vous cherchez un emploi et vous avez un entretien prochainement, vous me demandez comment le réussir (tenue, comportement, préparation, etc.).

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_012',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre voisin(e). Je m’absente en vacances et je cherche quelqu’un pour s’occuper de mon animal. Vous voulez en savoir plus avant d’accepter (dates, soins, règles, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_013',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je travaille à l’office de tourisme. Vous souhaitez planifier un week-end à prix réduit et vous me demandez des suggestions (activités, lieux à visiter, transports, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_014',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je travaille à l’accueil d’un club sportif de la ville. Vous envisagez de vous inscrire et vous me posez des questions (horaires, types de cours, tarifs, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_015',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Nous sommes amis et vous envisagez de vous installer au Canada. Je vous suggère de vivre avec moi en colocation à Toronto. Vous me demandez des informations pour décider si c’est une bonne solution pour vous (logement, quartier, routine, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_016',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Je m’installe à l’étranger et je ne peux pas transporter toutes mes affaires. J’ai mis cer tains objets en vente. Vous voulez en savoir plus et vous me posez des questions sur les articles à vendre (meubles, objets, tarifs, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_017',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Vous recevrez prochainement des amis qui ne connaissent pas votre ville. Vous me posez des questions pour les aider à organiser leur séjour (restaurants, visites, sorties, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_018',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) collègue. J’ai participé à un mariage ce week-end. Vous voulez savoir comment s’est déroulée la cérémonie (repas, lieu, ambiance, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_019',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) collègue. J’ai réalisé un tour touristique au Canada. Vous voulez faire la même expérience l’été prochain et me posez des questions sur le voyage (coût, étapes, temps, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_020',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je vis dans votre quartier. Je vais partir en vacances une semaine et j’ai besoin que quelqu’un garde mon chien. Vous souhaitez m’aider et vous me demandez des informations (durée, soins, paiement, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_001',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pour quelles raisons le métier de professeur peut-il paraître difficile ou impressionnant ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_002',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Les animaux de compagnie peuvent-ils rendre les personnes plus heureuses ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_003',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, que doit faire un jeune pour trouver un emploi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_004',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Quel problème mondial est le plus important aujourd’hui ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_005',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
À votre avis, jusqu’à quel âge est-il raisonnable de travailler ? Expliquez .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_006',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Le développement des achats sur Internet pourrait-il entraîner la disparition des magasins physiques ? Quel est votre avis ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_007',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que les jeunes s’impliquent moins aujourd’hui dans des domaines comme l’environnement, la politique ou la santé ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_008',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, devrait-on obliger toutes les personnes pouvant travailler depuis chez elles à pratiquer le télétravail ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_009',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il nécessaire de faire de longues études pour réussir dans sa vie professionnelle ? Quel est votre avis ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_010',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Vivre plusieurs mois dans un pays étranger est-il nécessaire pour aider les jeunes à devenir indépendants ? Êtes-vous d’accord ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_011',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Que pensez-vous des gens qui décident de ne jamais regarder la télévision ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_012',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Certains pensent que les salaires des sportifs professionnels sont excessives. Êtes-vous d’accord ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_013',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Croyez-vous que les enfants restent-ils trop longtemps devant les écrans (TV, téléphone, ordinateur, tablette) ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_014',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Quand on vit dans un nouveau pays, faut-il adapter son mode de vie (habits, nourriture, vacances, etc.) ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_015',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Serait-il simple de trouver un travail si vous installez au Canada ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_016',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Certains parents donnent de l’argent à leurs enfants quand ils réussissent bien à l’école. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_017',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’il soit possible de développer l’économie tout en préservant l’environnement ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_018',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il possible de connaître un pays uniquement en lisant des livres ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_019',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pour bien s’intégrer dans un nouveau pays, faudrait-il renoncer à ses traditions ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_020',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, est-il important qu’une entreprise privilégie le bien-être de ses salariés pour être efficace ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_021',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je propose mes services de cuisine à domicile. Vous organisez un dîner familial et vous me demandez des renseignements concernant mes services (menus proposés, prix, équipements, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_022',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e) et je prends souvent la voiture pour mes déplacements. Je vous suggère de faire du covoiturage ensemble. Vous êtes intéressé(e) et vous me demandez des précisions (horaires, coût, organisation, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_023',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) à l’accueil d’une école de musique. Vous désirez suivre des cours et vous me demandez des renseignements (tarifs, horaires, instruments, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_024',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) à l’accueil d’un centre sportif. Vous désirez vous inscrire et vous me demandez des informations sur les différents sports disponibles (prix, disciplines, horaires, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_025',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) à la réception d’un hôtel. Vous souhaitez faire une réservation et vous me demandez des renseignements (type de chambre, services, tarifs, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_026',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je fais partie d’une association qui protège les animaux. Je vous invite à nous rejoindre. Vous me posez des questions pour mieux connaître cette association (activités, services, personnes aidées, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
);

INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
(
  'expression_orale',
  2,
  'EO_T2_027',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Nous sommes collègues. Je viens de voir un film au cinéma. Vous me posez des questions sur ce film pour savoir si vous voulez y aller (acteurs, histoire, horaires, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_028',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre nouveau collègue. J’ai vécu au Québec et maintenant je vis dans votre pays. Vous me posez des questions sur mon parcours (études, début de travail, expériences à l’étranger, difficultés, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_029',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je travaille dans une agence immobilière. Vous venez d’arriver au Québec et cherchez un logement. Vous me posez des questions sur la recherche d’appartement (procédures, quartiers, types de logement, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_030',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis bibliothécaire. Vous voulez vous inscrire à la bibliothèque. Vous me posez des questions pour mieux comprendre comment ça fonctionne (inscription, activités, horaires, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_031',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) francophone. Vous devez préparer un article sur un film pour le journal de votre association culturelle. Vous cherchez des idées. Vous me posez des questions sur les films que j’ai aimés (endroit, genre, prix, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_032',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je travaille dans une agence de voyages. Vous voulez préparer des vacances. Vous venez me voir et vous me demandez des renseignements sur les lieux proposés (activités, visites, prix, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_033',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre voisin(e). Vous souhaitez organiser une rencontre conviviale entre habitants de l’immeuble. Vous me posez des questions pour avoir des idées (animations, invitées, repas, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_034',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Vous vous êtes récemment installé(e) dans la ville et vous n’avez pas encore de relations. Vous me posez des questions pour savoir comment faire des connaissances .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_035',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Vous souhaitez connaître le rythme professionnel au Canada. Vous me demandez des informations sur les heures de travail et les vacances. Puis, vous faites une comparaison avec votre pays .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_036',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis parent d’un élève et nos enfants fréquentent la même école. Vous assistez à la fête de l’école pour la première fois et vous me demandez des informations sur l’événement (programme, horaires, animations, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_037',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) et je vis dans une grande ville. Vous souhaitez louer un logement ici. Vous me demandez des informations (offres disponibles, prix, quartier, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_038',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans un club de sport. Vous souhaitez vous inscrire à une activité physique. Vous me demandez des renseignements pour faire votre choix (sports disponibles, horaires, coût, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_039',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans une agence de voyages. Vous voulez planifier vos vacances et vous me demandez des informations (coût, destinations, activités, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_040',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) à la ludothèque de votre ville. Vous souhaitez adhérer et vous me me posez des questions (horaires, prix, jeux disponibles, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_041',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Vous venez d’emménager dans l’immeuble et nous faisons connaissance dans l’ascenseur. Posez-moi des questions (quartier, magasins, activités, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_042',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis agent immobilier. Vous souhaitez louer un chalet près de la mer pour vos vacances. Posez-moi des questions .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_043',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Vous venez de vous installer au Canada et vous souhaitez inscrire vos enfants dans une école. Posez-moi des questions .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_044',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) collègue. Je mets une chambre en colocation à votre disposition et cela vous intéresse. Posez-moi des questions .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_045',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) à l’accueil d’une école de danse. Vous cherchez des informations sur les cours de danse. Posez-moi des questions .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_046',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Vous souhaitez connaître comment s’est passée ma première journée dans mon nouveau poste (ambiance, personnels, missions, etc.).

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_047',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Une personne que je connais propose des cours de musique à la maison. Vous voulez en savoir plus et me posez des questions (prix, horaires, expérience, etc.)

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_048',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Vous voulez passer une journée à la campagne avec vos amis et vous me posez des questions pour bien organiser la sortie (transport, activités, endroit, etc.)

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_049',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je travaille dans une épicerie. Vous voulez que vos courses soient livrées chez vous et vous me demandez des informations (prix, délais, type de livraison, etc.)

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_050',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je travaille dans une agence immobilière. Vous voulez mettre votre appartement en location pour les vacances pour augmenter vos revenus et vous me posez des questions (tarifs, période de location, type de locataires, etc.)

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_021',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’il soit plus facile pour les jeunes de vivre à l’étranger ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_022',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que le travail à distance aide vraiment à mieux équilibrer la vie professionnelle et la vie privée ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_023',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
La présence de caméras dans les lieux publics permet-elle réellement d’améliorer la sécurité ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_024',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
L’habillement a-t-il une influence dans la vie de chaque jour ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_025',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que les actions simples de chaque jour puissent réellement avoir un impact sur la protection de la planète ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_026',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que réussir dans sa carrière dépend du niveau d’études et des diplômes ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_027',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, le travail des personnes âgées est-il utile pour la société ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_028',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Certaines personnes donnent de leur temps libre pour faire du bénévolat. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_029',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Entre le théâtre et le cinéma, que préférez-vous et pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_030',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
À votre avis, quel est le meilleur âge pour partir vivre à l’étranger ? Expliquez .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_031',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Que pensez-vous des personnes qui choisissent de voyager seules ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_032',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Vaut-il mieux travailler sous la responsabilité d’un homme ou d’une femme ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_033',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que les jeux vidéo peuvent participer à l’évolution d’un enfant ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_034',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pourquoi est-il important de développer le tourisme dans un pays ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_035',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que vivre dans un pays étranger soit difficile ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_036',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, doit-on protéger tous les animaux en voie de disparition ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_037',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
L’essentiel dans la vie est-il de trouver du bonheur au travail ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_038',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, lire est-il une activité inutile ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_039',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que l’on puisse être épanoui en vivant seul ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_040',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Le plus important pour conserver la santé est-il de bien se nourrir ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_041',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’il soit simple de trouver un emploi à l’étranger ? Êtes-vous d’accord ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_042',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Le stress peut-il encourager une personne à donner le meilleur d’elle-même ? Expliquez .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_043',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il utile d’imposer des règles strictes à ses enfants ? Donnez votre avis .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_044',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Comment jugez-vous la cuisine et la nourriture dans votre pays ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_045',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que la télévision contribue à l’éveil et à l’apprentissage des enfants ? Êtes-vous d’accord ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_046',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que l’expérience de la vie à l’étranger aide à réussir professionnellement ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
);

INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
(
  'expression_orale',
  3,
  'EO_T3_047',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que le tourisme puisse favoriser le développement dans tous les pays ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_048',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’il est compliqué de s’adapter dans un pays étranger ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_049',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il mieux d’apprendre une langue étrangère dès l’enfance ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_050',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pourquoi, selon vous, les gens s’intéressent-ils à la vie des célébrités ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_051',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre collègue. Je participe à un club de jeux de société. Vous souhaitez en savoir plus et me demandez des renseignements (lieu, prix, heures, ambiance, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_052',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre collègue. Je prépare une soirée pour célébrer ma retraite et vous êtes invité(e). Vous voulez en savoir plus (date, lieu, invités, programme, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_053',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). J’organise des activités de jardinage dans le quartier. Vous êtes intéressé(e) et vous me demandez des informations (coût, organisation, activités proposées, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_054',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) à la bibliothèque municipale. Vous voulez emprunter des documents et vous me posez des questions sur la procédure (durée, quantité autorisée, conditions, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_055',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis à la réception de la piscine municipale. Vous souhaitez prendre des leçons de natation et me demandez des renseignements (prix, horaires, accès, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_056',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Je prépare la fête des voisins pour le week-end prochain. Vous souhaitez y assister et vous me posez des questions sur l’organisation (lieu, horaires, nourriture à apporter, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_057',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Je vais souvent en vacances dans une station de ski au Canada. Ce type de voyage vous intéresse et vous me posez des questions pour savoir si cela pourrait vous convenir (destination, hébergement, activités, etc. ).

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_058',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Je me déplace au travail à vélo chaque jour. Vous souhaitez adopter ce mode de transport en ville et vous me demandez des renseignements pour savoir si c’est adapté (points positifs, budget, sécurité, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_059',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) à l’office de tourisme de Vancouver. Vous souhaitez aller dans un musée et vous me demandez des informations sur les musées de la ville (types, tarifs, heures d’ouverture, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_060',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) collègue. Je fais du télétravail quelques jours chaque semaine. Vous souhaitez en savoir plus et vous me posez des questions sur mon travail à domicile (planning, matériel, organisation, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_061',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) canadien(ne). Vous réalisez un sondage sur mes activités pendant le week-end au Canada. Vous me posez des questions (mes occupations, les lieux que je visite, le moment, les personnes qui m’accompagnent, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_062',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Je viens de me marier au Canada. Vous me posez des questions afin de comparer le mariage dans votre pays et celui au Canada (coutumes, préparation, invités, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_063',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) francophone. J’ai pris part à une compétition sportive. Vous souhaitez en savoir plus et vous me posez des questions sur mon expérience et sur mon entraînement pour une prochaine compétition .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_064',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) collègue. Vous êtes en voyage professionnel au Canada. Vous me interrogez pour découvrir la manière dont les Canadiens passent leurs soirées (endroits, activités, habitudes, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_065',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). J’ai fait un voyage en famille dans une ville francophone. Vous souhaitez en savoir plus et vous me posez des questions concernant ce voyage (activités, dépenses, organisation, préparatifs, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_066',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Je déménage le week-end prochain. Vous allez m’aider et vous me demandez des informations pour organiser la journée (heure, lieu, transport, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_067',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). J’utilise régulièrement une plateforme en ligne qui organise des sorties en groupe. Vous êtes intéressé(e) et vous me posez des questions pour en savoir plus (inscription, participants, activités, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_068',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Vous souhaitez offrir un cadeau à mon enfant pour son anniversaire. Vous me posez des questions pour choisir le bon cadeau (jeux, habitudes, préférences, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_069',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans un restaurant. Vous voulez préparer un dîner avec vos collègues. Vous me posez des questions sur lieu (menu, prix, ambiance, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_070',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans une agence immobilière au Canada. Vous cherchez un appartement. Vous me posez des questions pour vous renseigner (prix, conditions, procédures, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_071',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Vous passez vos vacances au Canada et vous voulez aller au cinéma. Votre ami(e), employé(e) dans ce cinéma, peut vous renseigner sur les films à l’affiche, les heures des séances et les prix. Vous lui demandez des précisions pour faire votre choix .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_072',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Un(e) ami(e) vient de passer des vacances au bord de la mer. Vous souhaitez préparer un séjour semblable et vous lui demandez des informations (lieu, activités possibles, coût du voyage, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_073',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Vous devez rédiger un article sur un livre pour le magazine de votre association littéraire. Afin de trouver des idées, vous échangez avec un(e) ami(e) francophone au sujet de ses lectures récentes .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_074',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Votre ami(e) a pris part à une émission de télévision. Puisque vous souhaitez tenter la même expérience, vous lui demandez des informations (procédure d’inscription, l’organisation, l’intérêt de cette expérience, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_075',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Vous arrivez dans une nouvelle ville et vous souhaitez vous renseigner sur les transports publics. Vous vous adressez à un(e) employé(e) pour obtenir des renseignements (moyens de transport, horaires, prix, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_076',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) français(e). Vous voulez passer l’été en France, mais vous ne savez pas encore quelle ville choisir. Vous me demandez des informations pour les comparer (temps, activités, transports, etc.) et choisir la meilleure destination .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_077',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Je souhaite trouver un appartement à louer. Vous essayez de m’aider et vous me demandez des informations (quartier, budget, superficie, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_078',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) collègue. J’ai participé à une formation du soir à l’université pendant une année. Vous souhaitez en savoir plus et vous me posez des questions sur ces cours (enseignants, horaires, tarifs, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_079',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans une agence de voyages. Vous pensez partir en vacances au Canada. Vous me demandez des informations pour comparer les offres (destinations, prix, prestations incluses, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_080',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans la réception d’un centre culturel et sportif à Ottawa. Vous êtes nouveau dans le quartier et vous voulez vous inscrire à des activités. Vous me demandez des renseignements (sports, horaires, tarifs, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_081',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis agent immobilier et vous souhaitez acheter un appartement et une offre vous intéresse. Vous me demandez alors des précisions sur le bien (superficie, coût, quartier, services à proximité, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_082',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis parent d’un enfant de l’école. Vous cherchez une activité pour vos enfants après les cours. Vous me demandez des précisions sur les options disponibles près de l’école (type d’activité, prix, horaires, encadrement, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_083',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) engagé(e) dans une association qui offre des repas aux personnes sans abri. Vous souhaitez vous engager à votre tour et vous me demandez des informations sur l’association (règles, missions, horaires, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_084',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ancien(ne) collègue et j’ai récemment commencé un nouvel emploi. Vous envisagez de changer de travail et vous me demandez des informations sur ma société (tâches, environnement, avantages, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_085',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Nous partageons le même immeuble. Je vous propose de garder mon enfant pendant le week-end. Vous êtes d’accord et vous m’interrogez sur les détails pratiques (temps de garde, repas, sorties, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_086',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) canadien(ne) que vous n’avez pas vu(e) depuis un long moment. Vous vous informez sur ma situation et vous m’interrogez sur ma vie quotidienne (emploi, proches, passe-temps, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_087',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). J’ai un paquet à envoyer, mais je ne peux pas m’en occuper. Je vous sollicite pour m’aider. Vous me demandez des informations pour vérifier si vous pouvez le prendre en charge (délai, taille du colis, durée de la démarche, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_088',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Je vous propose de venir célébrer l’anniversaire de ma sœur. Vous me demandez des renseignements sur elle afin de choisir un cadeau approprié (goûts, loisirs, personnalité, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_089',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Vous avez envie de commencer une série, mais vous êtes indécis(e). Vous me demandez des informations pour faire votre choix (catégorie, acteurs, plateforme de streaming, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_090',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Vous venez d’emménager au Canada. Je suis un collègue. Vous voulez faire de nouvelles connaissances et vous demandez comment procéder (activités, endroits, sorties, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_051',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Actuellement, maîtriser plusieurs langues est très utile. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_052',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il important que tout le monde puisse profiter de la culture sans frais (musées, livres, spectacles, etc.) ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_053',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pour protéger la planète, faut-il acheter des aliments produits localement et selon les saisons ? Êtes-vous d’accord ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_054',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Quel travail souhaiteriez-vous essayer un jour ? Justifiez .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_055',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’il soit important que chacun puisse travailler depuis chez lui s’il le désire ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_056',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
De nos jours, est-il faisable de vivre sans télévision ? Expliquez .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
);

INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
(
  'expression_orale',
  3,
  'EO_T3_057',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Actuellement, beaucoup de gens cherchent à améliorer leur apparence. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_058',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-ce que le stress peut devenir un facteur de motivation ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_059',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Les métiers les plus difficiles devraient-ils être mieux payés ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_060',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
D’après vous, quelles mesures un pays peut-il adopter pour faciliter l’intégration des étrangers ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_061',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que le téléphone portable personnel devrait être interdit au travail ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_062',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Les ONG et les associations sont-elles les seules capables d’aider les personnes pauvres ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_063',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que les disciplines culturelles (musique, dessin, théâtre, etc.) ne devraient pas faire partie de l’enseignement scolaire ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_064',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-ce que maîtriser la langue du pays d’accueil est suffisant pour réussir son intégration ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_065',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, la télévision est-elle indispensable à l’éducation des enfants ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_066',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que l’autorité soit indispensable pour bien éduquer les enfants ? Justifiez votre point de vue .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_067',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Quels impacts et quels risques peuvent avoir l’usage régulier des téléphones, des ordinateurs et des tablettes ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_068',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pour favoriser l’égalité, certains pays imposent la parité hommes-femmes dans le domaine politique. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_069',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il nécessaire de vivre dans un pays pour vraiment comprendre sa culture ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_070',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il facile de travailler dans un autre pays ? Expliquez pourquoi .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_071',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
De plus en plus de parents choisissent d’enseigner eux-mêmes à leurs enfants à domicile plutôt que de les inscrire à l’école. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_072',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
D’après vous, qui doit aider les personnes en situation difficile : le gouvernement ou les citoyens ? Quel est votre avis ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_073',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Suivre des études tout en ayant un travail est difficile. Partagez-vous cette opinion ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_074',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Tout le monde peut participer au tri des déchets. Êtes-vous d’accord ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_075',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, devrait-on empêcher l’usage du téléphone portable à l’école ? Pour quelles raisons ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_076',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Aujourd’hui, les personnes n’échangent presque plus de lettres ou de cartes (de vœux, d’amour, etc.). Pensez-vous que c’est dommage ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_077',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’il soit possible de vivre sans voiture dans la vie actuelle ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_078',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’il soit plus simple de vivre seul(e) que de vivre en famille ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_079',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il raisonnable de faire travailler les personnes jusqu’à l’âge de 70 ans ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_080',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Vivre une expérience à l’étranger apporte toujours des avantages. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_081',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Tout le monde peut agir pour produire moins de déchets. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_082',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Il est possible de se remettre aux études ou de commencer des études à tout âge. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_083',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Les métiers liés à l’art (cinéma, musique, peinture, etc.) ne sont pas vus comme de vrais emplois. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_084',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Les personnes âgées offrent souvent des conseils utiles. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_085',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Grâce aux réseaux sociaux, il est plus facile de se faire des connaissances et des amitiés. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_086',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, les livres ont-ils perdu leur utilité dans la société actuelle ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_087',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il possible de se passer de médicaments aujourd’hui ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_088',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-ce plus facile de s’adapter à un nouveau pays quand on est jeune ? Quel est votre avis ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_089',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, les prestations sociales réduisent-elles la solidarité entre les membres d’une famille ? Expliquez .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_090',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, est-il nécessaire de suivre de longues études pour réussir dans la vie ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_091',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis l''assistant(e) de votre docteur. Il est en congé et vous me demandez des informations précises sur le praticien qui le remplace (nom, horaires, durée de remplacement etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_092',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) à vous. J''ai été récemment engagé(e) par une société implantée dans la périphérie de Toronto. Vous me sollicitez pour obtenir des renseignements sur mon nouveau poste (mes coéquipiers, les bureaux, les bénéfices, les événements organisés, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_093',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) à vous. Je dispose d''une expérience significative en blogage. Vous souhaitez lancer un site personnel en prévision de votre futur séjour au Canada et vous me sollicitez pour des recommandations (organisation, fréquence de publication, type de contenus, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_094',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) à vous. Vous souhaitez planifier un séjour au Canada afin de célébrer l''anniversaire de votre conjoint(e) et vous me posez des questions (destinations, activités, coûts, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_095',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Vous déménagez pour vous établir au Canada et vous cherchez une place en colocation. Je vous propose mon appartement. Vous souhaitez obtenir des informations pour comprendre l''organisation de cette cohabitation (pièces communes, montant du loyer, colocataires, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_096',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Je me suis installé(e) au Canada il y a quelques mois. Vous me demandez des informations sur ma vie là-bas (logement, loisirs, relations, emploi, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_097',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) collègue. J’envisage de changer de service au sein de l’entreprise. Vous me demandez des informations pour savoir ce qui motive ce changement (tâches, horaires, ambiance, collègues, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_098',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans une agence de voyages. Vous avez remporté un voyage à la suite d’un concours et vous devez choisir votre destination entre Montréal, Dakar, Bruxelles ou Hanoï. Vous me posez des questions sur ces villes (météo, activités, budget, etc.) pour vous décider .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_099',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
J’ai mis une annonce car j’ai besoin de quelqu’un pour accompagner mes enfants à l’école. Vous avez répondu et nous avons un rendez-vous. Vous me demandez des informations sur le poste (horaires, école, responsabilités, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_100',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
J’organise un festival de cinéma francophone. Vous êtes en vacances dans ma ville où nous nous sommes croisés. Vous me demandez des informations sur le festival pour savoir si vous allez y assister (dates, programme, horaires, tarifs, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_101',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je loue une chambre dans mon appartement. Vous avez consulté mon annonce et venez visiter le logement. Vous me demandez des informations sur la chambre et la location (prix, équipement, vie en colocation, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_102',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Je vous propose de venir à l’inauguration d’un restaurant. Vous me demandez des informations sur l’événement (tenue, repas, programme, participants, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_103',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) collègue. Je ne pourrai pas aller récupérer mes parents à l’aéroport ce week-end. Vous proposez de m’aider et vous me demandez des informations pour organiser leur arrivée (date, heure, vol, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_104',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) collègue. Je vends des meubles et j’ai mis une annonce. Vous souhaitez acheter et vous me demandez des informations sur les objets (état, dimensions, coût, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_105',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Vous venez de vous installer dans l’immeuble. Vous me demandez des informations sur le quartier (commerces, loisirs, activités sportives, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_106',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). J’ai pris part à une émission de télévision. Vous souhaitez en savoir davantage. Vous me posez des questions sur cette aventure (inscription, organisation, intérêt, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
);

INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
(
  'expression_orale',
  2,
  'EO_T2_107',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Vous souhaitez déménager dans ma ville. Vous me demandez des informations afin de trouver un quartier adapté à votre situation (atmosphère, coût des loyers, services disponibles, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_108',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre voisin(e). J’anime des activités sportives dans un centre communautaire. ous aimeriez découvrir cette activité. Vous me posez des questions sur son fonctionnement (types de séances, horaires, participants, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_109',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans une agence de location de vélos au Canada. Vous aimeriez visiter la ville pendant votre séjour. Vous me posez des questions pour obtenir des informations (modèles proposés, conditions de location, prix, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_110',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis conseiller(ère) dans une agence de tourisme. Vous envisagez de faire une croisière au Canada. Vous me demandez des renseignements sur les offres disponibles (nombre de jours, prix, loisirs à bord, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_111',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e ) ami(e) et j’habite au Canada depuis longtemps. Vous prévoyez de me rendre visite au mois de décembre. Vous me demandez des informations pour organiser votre voyage et vos bagages (climat, températures, habits, activités possibles, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_112',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) collègue et je vous propose de partager mon logement. Vous me demandez des informations sur le logement, les règles à respecter et mon mode de vie afin de décider si vous acceptez .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_113',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Vous avez envie d’aller voir un film et vous me demandez des informations sur les films que j’ai vus dernièrement (genre, durée, acteurs, opinion, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_114',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e) et je pratique la natation toutes les semaines. Vous souhaitez en savoir plus et vous me demandez des informations sur la piscine où je vais (horaires, prix, équipements, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_115',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans une agence de voyage. Vous allez voyager au Canada en avion et vous me demandez des informations sur le voyage (enregistrement, bagages, embarquement, services à bord, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_116',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis le gérant d’un restaurant et je recrute un(e) employé(e). Vous souhaitez postuler et vous me demandez des informations (poste proposé, horaires, salaire, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_117',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) et je participe à des cours de pâtisserie depuis un certain temps. Vous êtes intéressé(e) et vous me demandez des renseignements (coût, endroit, recettes apprises, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_118',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans une agence de voyages. Vous souhaitez préparer vos vacances et vous me demandez des renseignements (lieux à visiter, hébergement, coût, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_119',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) à l’accueil d’un centre de loisirs. Vous voulez inscrire votre enfant à un atelier et vous me demandez des renseignements (horaires, prix, activités proposées, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_120',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e), je fais appel à quelqu’un pour m’aider à la maison (ménage, jardin, petits travaux, etc.). Vous êtes intéressé(e) et vous me demandez des informations (tâches, tarifs, horaires, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_121',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Je voudrais préparer une sortie familiale pour dimanche prochain. Vous acceptez de m’aider et vous me demandez des informations pour bien préparer cette sortie (destination, loisirs, budget, transport, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_122',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) et je réside au Canada. Vous prévoyez de vous installer prochainement ici. Vous me demandez des informations concernant les transports (types de transport, coût, horaires, rapidité, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_123',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). J’ai mis une annonce dans la résidence pour vendre un meuble. Vous souhaitez l’acheter et vous me demandez des informations (état du meuble, prix, transport, date, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_124',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Vous êtes arrivé(e) récemment au Canada. Je suis un(e) ami(e) et je vous accueille chez moi pour quelques jours. Vous me posez des questions pour trouver et louer un logement (prix du loyer, quartiers, formalités, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_125',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Vous passez quelques jours dans un hôtel. Je suis employé(e) à l’accueil. Vous me demandez des informations pour bien organiser votre séjour (petit-déjeuner, Wi-Fi, déplacements, activités à faire, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_126',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis à l’accueil d’un centre sportif. Vous souhaitez vous inscrire et vous me posez des questions pour vous informer (activités sportives, horaires, tarifs, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_127',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Je suis chauffeur et je propose de partager mes trajets en voiture. Vous êtes intéressé(e) et vous me posez des questions sur ce système (prix, heures, fonctionnement, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_128',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) à l’accueil d’un hôtel. Vous souhaitez faire une réservation. Vous me posez des questions, et je vous fournis des renseignements (prix, catégorie de chambre, petit-déjeuner, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_129',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je travaille comme chef cuisinier/cheffe cuisinière à domicile. Vous souhaitez préparer un repas en famille. Vous me posez des questions sur ce que je peux offrir (menus, équipement, prix, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_130',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) à l’accueil d’une école de langues. Vous souhaitez vous inscrire à un cours. Vous me posez des questions (programmes, horaires, tarifs, etc.), et je vous fournis des renseignements .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_131',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis à la recherche d’un emploi de garde d’enfants. Vous cherchez une personne pour garder votre enfant après les cours. Vous me posez des questions afin de décider si vous allez m’embaucher (horaires, expérience, prix, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_132',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) et je viens de passer un excellent séjour au Canada. Vous aimeriez faire pareil. Vous me posez des questions sur ce voyage (endroits visités, loisirs, prix, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_133',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Je prends souvent part à des activités artistiques proposées par la mairie (danse, musique, cinéma, etc.). Vous êtes intéressé(e). Vous me posez des questions sur les cours, les tarifs, les horaires, etc .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_134',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). J’ai une boutique. Vous rêvez d’avoir votre propre magasin. Vous me posez des questions sur mon travail (jours d’ouverture, articles proposés, clientèle, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_135',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans un magasin de déguisements. Vous avez besoin d’un costume pour une soirée. Vous me posez des questions (types de tenues, règles de location, prix, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_136',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e ) collègue et j’ai effectué un court séjour dans une région canadienne. Vous me demandez des informations sur mon expérience (sites visités, type de logement, activités réalisées, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_137',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) collègue. Vous vous êtes récemment installé au Canada et vous m’interrogez sur le système de santé canadien (docteurs, établissements de soins, congés maladie, médicaments, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_138',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je travaille dans un bureau de tourisme. Vous souhaitez visiter un parc de loisirs (aquarium, zoo, parc naturel). Vous me demandez des renseignements (heures d’ouverture, prix, services de restauration, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_139',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans une agence touristique au Canada. Vous prévoyez une croisière et vous me demandez des informations (coûts, durée, animations proposées, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_140',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Vous venez voir un logement en location. Je suis l’ancien locataire. Vous me demandez des informations sur l’immeuble, le voisinage, la présence d’un gardien et le secteur .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_141',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je travaille dans une agence qui loue des bicyclettes. Vous désirez en louer une. Vous me demandez des renseignements (modèles disponibles, prix, utilisation, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_142',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre ami(e) canadien(ne). Vous êtes nouvellement arrivé(e) dans ma ville et vous êtes hébergé(e) chez moi. Vous souhaitez vous promener en ville et vous me posez des questions sur les transports publics (types, trajets, horaires, prix, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_143',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre ami(e) francophone. Vous devez rédiger un article sur une ville pour un magazine culturel. Vous cherchez de l’inspiration et vous me posez des questions sur les villes que j’apprécie (loisirs, bâtiments, moyens de transport, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_144',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre ami(e). Je mets en place un festival musical dans votre ville. Vous voulez y assister et vous me posez des questions pour en savoir plus (calendrier, horaires, artistes, tarifs, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_145',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre enseignant(e) de français. Vous allez célébrer le prochain Nouvel An au Canada et vous voulez découvrir leurs façons de célébrer. Vous me demandez des renseignements pour mieux comprendre (endroits, animations, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_091',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
La diversité sociale et culturelle à l''école favorise-t-elle l''esprit de tolérance chez les élèves ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_092',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Partir vivre à l''étranger avec ses proches est-ce moins difficile que de s''y rendre seul(e) ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_093',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il nécessaire que les organisations fournissent des opportunités d''apprentissage régulières à leur personnel ? Cet accès est-il profitable à l''individu ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_094',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Le principal facteur de succès professionnel dans sa compagnie est la maîtrise de son métier. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_095',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il réellement possible de changer ses coutumes alimentaires à l''âge adulte ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_096',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Faut-il inclure l’enseignement des technologies modernes (Internet, réseaux sociaux, etc.) dans le programme scolaire ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_097',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Certaines personnes estiment qu’il est impossible de combattre le stress. Quel est votre avis ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_098',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Quelles peuvent être les motivations d’une personne pour étudier à l’étranger ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_099',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Quel est votre avis sur le fait de posséder un animal domestique chez soi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_100',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
D’après vous, comment les jeux vidéo influencent-ils les enfants ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_101',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Il est préférable de ne pas travailler avec ses proches. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
);

INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
(
  'expression_orale',
  3,
  'EO_T3_102',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Passer du temps devant la télévision est-il du temps perdu ? Êtes-vous d’accord ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_103',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que les smartphones rendent les échanges plus simples ? Êtes-vous d’accord ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_104',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Quand on habite à l’étranger, faut-il rencontrer des personnes de son pays d’origine ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_105',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
La présence des produits bio augmente dans les grandes surfaces. Selon vous, est-ce une évolution bénéfique ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_106',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Faut-il aimer ce que l’on fait pour travailler dans de bonnes conditions ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_107',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que la réussite scolaire est une garantie de succès dans la vie ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_108',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Êtes-vous d’accord avec l’idée que les immigrants apportent beaucoup à la société d’un pays ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_109',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’il est utile de s’informer chaque jour afin de mieux connaître le monde qui nous entoure ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_110',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, l’utilisation des réseaux sociaux fait-elle perdre un temps précieux ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_111',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
De nos jours, grâce à Internet, les relations à distance peuvent-elles être aussi solides que les relations directes ? Partagez-vous cet avis ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_112',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, est-ce que les jeunes ont plus de facilité à apprendre une langue étrangère que les personnes âgées ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_113',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pourquoi, selon vous, certaines personnes ne montrent-elles pas d’intérêt pour la politique ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_114',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que vivre en ville provoque toujours du stress ? Êtes-vous d’accord ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_115',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’il est nécessaire d’avoir une expérience à l’étranger durant sa carrière professionnelle ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_116',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Croyez-vous que les personnes continuent à cuisiner régulièrement aujourd’hui ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_117',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’il soit compliqué de s’habituer à vivre dans un autre pays ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_118',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Faites-vous confiance aux informations que vous consultez sur le web ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_119',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
À votre avis, la famille occupe-t-elle la place la plus importante dans la vie ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_120',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’il soit important que filles et garçons reçoivent la même éducation ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_121',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Il faut avoir beaucoup d’argent pour être heureux dans la vie. Êtes-vous d’accord ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_122',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
D’après vous, Internet a-t-il changé les habitudes dans le monde du travail ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_123',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Quel média utilisez-vous le plus pour vous informer : les journaux, la radio, la télévision, Internet ou les réseaux sociaux ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_124',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’il est important de faire connaissance avec les habitants pour bien vivre dans un pays étranger ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_125',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Quand une famille s’installe à l’étranger, est-il préférable de parler aux enfants dans la langue du pays d’accueil ou dans la langue d’origine ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_126',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que les vêtements que l’on porte ont de l’importance dans la vie ? Justifiez .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_127',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Le télétravail aide à trouver un bon équilibre entre travail et vie privée. Quel est votre avis ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_128',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pour la protection de la planète, les efforts de chaque personne (tri, économie d’électricité, etc.) sont nécessaires. Êtes-vous d’accord ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_129',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Partir vivre à l’étranger est plus facile quand on est jeune. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_130',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
La présence de caméras dans les lieux publics améliore la sécurité des personnes. Êtes-vous d’accord ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_131',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Il y a des personnes qui passent presque tout leur temps à travailler. Quel est votre avis ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_132',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Il y a des parents qui décident de s’occuper eux-mêmes de l’éducation de leurs enfants à la maison. Quel est votre avis ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_133',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Donner un téléphone portable à un enfant n’est pas conseillé. Quel est votre avis ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_134',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Certaines personnes pensent qu’il faut être riche pour être heureux. Quel est votre avis ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_135',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Les universités doivent accepter tous les étudiants sans processus de sélection. Partagez-vous cette opinion ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_136',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’il soit simple de préserver sa culture d’origine en vivant à l’étranger ? Expliquez pourquoi.

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_137',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Faut-il toujours dire toute la vérité aux enfants ? Donnez votre avis .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_138',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que les établissements scolaires devraient valoriser davantage les activités liées à l’art (musique, théâtre, arts visuels, etc.) ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_139',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Que pensez-vous des habitudes de consommation dans les pays riches ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_140',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
À votre avis, les enfants peuvent-ils aider à mieux s’intégrer lorsqu’on arrive dans un pays étranger ? Expliquez pourquoi.

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_141',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Quel est votre avis sur les actions prises dans votre pays pour diminuer la pollution ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_142',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
À votre avis, vivre de longues années à l’étranger fait-il oublier sa culture d’origine ? Expliquez .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

��� Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_143',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
À votre avis, les jeux vidéo peuvent-ils nuire aux enfants ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_144',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Connaître le pays d’accueil est-il essentiel pour un immigrant ? Expliquez pourquoi.

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_145',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Que recherchent les gens lorsqu’ils choisissent de vivre dans un autre pays ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_146',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis membre d’une association pour la défense des animaux. Je vous invite à y participer. Vous me posez des questions pour obtenir plus d’informations (activités, actions, public visé, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_147',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) collègue. Je viens de regarder un film au cinéma. Vous me demandez des informations pour savoir si ce film peut vous plaire (histoire, acteurs, horaires, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_148',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) nouveau collègue. J’ai habité au Québec et je travaille actuellement ici. Vous me posez des questions sur mon expérience professionnel (études, premiers emplois, expérience à l’étranger, difficultés, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_149',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans une agence immobilière. Vous venez de vous installer au Québec et vous cherchez un appartement. Vous me posez des questions pour vous aider à trouver un logement (procédures, quartier, logement, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_150',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) à la bibliothèque. Vous voulez devenir membre. Vous me posez des questions sur le fonctionnement (inscription, horaires, activités, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_151',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Pour vos cours de français, vous effectuez une enquête concernant les activités d’un jeune étudiant originaire d’un pays francophone. Je joue le rôle de cet étudiant et vous celui de l’enquêteur. Vous me posez différentes questions .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
);

INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
(
  'expression_orale',
  2,
  'EO_T2_152',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé dans une librairie qui propose un jeu destiné au public. Vous me demandez des informations (inscription, contenu, utilité, etc.) pour savoir si vous souhaitez participer .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_153',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) canadien(ne) et je participe à une activité artistique (danse, musique, théâtre, etc.). Vous êtes intéressé(e) et aimeriez la pratiquer aussi. Vous me demandez des renseignements (lieu, intérêt, horaires, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_154',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) francophone. Vous envisagez de venir vivre dans ma ville et souhaitez des informations pour trouver un logement (procédures, lieux, coût, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_155',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) francophone. Vous voulez choisir un endroit pour voyager et souhaitez connaître les pays que j’ai visités. Vous me posez des questions pour en savoir plus (activités, météo, prix, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_156',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) et je participe régulièrement à des voyages organisés. Vous voulez essayer ce type de vacances. Vous me demandez des conseils pour préparer votre voyage (destination, budget, activités, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_157',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). J’apprends des cours de dessin dans une école. Vous souhaitez en savoir plus et vous me posez des questions pour obtenir des informations (prix, l’école, enseignants, horaires, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_158',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) et vous venez d’arriver dans ma ville. Vous voulez profiter de votre week-end et vous me posez des questions pour découvrir les endroits (quartiers vivants, activités à faire, lieux à visiter, etc.).

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_159',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Vous avez envie de passer un week-end dans une ville que je connais bien. Afin de préparer votre séjour, vous me demandez des informations sur cette ville (lieux à visiter, climat, activités, hébergement, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_160',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) à l’accueil d’une bibliothèque. Vous voulez devenir membre et vous me posez des questions pour comprendre son fonctionnement (inscription, conditions de prêt, horaires, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_161',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Vous venez de vous installer dans l’immeuble et nous nous rencontrons dans l’ascenseur. Vous me demandez des informations (voisins, ambiance, etc) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_162',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Je dois sortir demain soir et vous acceptez de vous occuper de mon enfant. Vous me posez des questions pour connaître ses goûts et ses habitudes .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_163',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Vous venez d’arriver à Montréal et vous cherchez des endroits pour faire vos achats. Vous me posez des questions sur les possibilités (commerces, produits, prix) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_164',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je travaille dans une agence de voyages qui propose des séjours pour apprendre des langues. Vous souhaitez en savoir plus et vous me posez des questions pour vous renseigner (lieux, tarifs, organisateurs) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_165',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je travaille à la réception de la maison des associations. Vous voulez vous inscrire et vous me posez des questions sur les activités disponibles (cours, horaires, prix, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_166',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre collègue de travail. J’aimerais trouver un partenaire pour faire du sport. Vous êtes curieux(se) et vous me demandez des précisions sur ce sport (genre d’activité, heures, niveau, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_167',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e) et nos enfants sont copains. Je vous suggère que votre enfant nous accompagne pendant nos vacances. Vous me demandez des renseignements avant de dire oui (dates, destination, activités, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_168',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e) et je fais du bénévolat dans une association qui protège l’environnement. Vous êtes intéressé(e) à y participer et vous me demandez des précisions (activités, heures, membres, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_169',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans une agence de voyages spécialisée dans les excursions d’une journée. Vous souhaitez en savoir plus et vous me demandez des précisions (prix, programme, destinations, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_170',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) à la réception d’un musée. Vous voulez organiser une visite en famille et vous me demandez des précisions (horaires, expositions, tarifs, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_171',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) et je m’en vais en vacances pour un moment. Je vous confie la surveillance de mon appartement durant ce temps. Vous me demandez des précisions (dates, choses à faire, instructions, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_172',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) et je me suis installé(e) au Québec il y a deux ans. Vous souhaitez vivre à l’étranger et vous me demandez des renseignements sur mon expérience (adaptation, obstacles, changements de mode de vie, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_173',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e) et j’enseigne le piano dans une école de musique du quartier. Vous souhaitez prendre des cours et vous me demandez des informations sur l’établissement (types de cours, prix, horaires, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_174',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e) et j’anime des activités sportives dans une association du quartier. Vous voulez rejoindre mes séances et vous me demandez des informations sur les entraînements (conditions, discipline, horaires, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_175',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Vous avez l’intention de découvrir une région du Québec. Vous venez à l’office du tourisme pour vous informer sur les options d’hébergement (catégories, localisation, tarifs, etc.). Je suis la personne qui vous renseigne .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_176',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Mon anniversaire arrive bientôt, vous souhaitez organiser une fête et vous m’interrogez sur les détails (endroit, heures, invités, ambiance, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_177',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Je désire continuer mes études au Canada. Vous me demandez des informations pour en savoir plus sur mon projet (ville, spécialité, buts, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_178',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). J’ai des objets lourds à transporter et aucun véhicule pour le faire. Vous me demandez des précisions pour m’aider à organiser cela (nature d''objets, distance, date, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_179',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Je peux vous recommander quelqu’un qui s’occupe des enfants à domicile. Vous souhaitez en savoir plus et me demandez des renseignements sur cette personne (prix, disponibilité, compétences, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_180',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) à l’office de tourisme canadien. Vous voulez passer un week-end relaxant et vous me demandez des recommandations (sorties, endroits à découvrir, déplacements, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_146',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, réussir sa carrière dépend-il surtout des études et du diplôme ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_147',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, est-ce positif que les personnes âgées restent actives dans le monde du travail ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_148',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
De nombreuses personnes consacrent leur temps libre à des activités bénévoles. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_149',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Préférez-vous regarder des films ou aller au théâtre ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_150',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, à quel âge est-il préférable d’émigrer ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_151',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
De nombreuses personnes n’apprécient pas de voyager seuls. Partagez-vous cette opinion ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_152',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pourquoi les gens s’intéressent-ils aux voyages en train, en avion ou en bus (selon le contexte local) ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_153',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il important d’apprendre à utiliser les nouvelles technologies (Internet, réseaux sociaux, etc.) dès l’enfance ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_154',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Quelles sont les raisons qui peuvent pousser une personne à s’engager dans une action humanitaire ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_155',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Faut-il maîtriser la langue du pays où l’on réside ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_156',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
S’installer à l’étranger, est-ce changer de culture ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_157',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Aujourd’hui, les jeunes sont de moins en moins respectueux. Êtes-vous d’accord ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_158',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Il n’est pas facile de vivre en solitaire. Êtes-vous d’accord ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_159',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’il est facile de se faire des amis dans un pays étranger ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_160',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Peut-on se passer d’Internet dans la vie quotidienne ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_161',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
De nos jours, il est possible de vivre sans voiture. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_162',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Le développement du télétravail en est une amélioration pour tous. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_163',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Peut-on vivre aujourd’hui sans téléphone portable ? Quel est votre avis ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_164',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que les personnes célèbre devraient jouer un rôle plus actif dans la vie publique ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_165',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Vivre à l’étranger implique-t-il de rester proche de la communauté de son pays natal ? Quel est votre avis ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_166',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’on puisse vivre aujourd’hui sans Internet ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
);

INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
(
  'expression_orale',
  3,
  'EO_T3_167',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
À votre avis, faut-il de l’autorité pour élever correctement un enfant ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_168',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que les transports en commun doivent être accessibles gratuitement à tous les habitants des grandes villes ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_169',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
La bonne santé exige-t-elle de consommer seulement des produits biologiques ? Êtes-vous d’accord ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_170',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Faut-il avoir un niveau d’études élevé pour réussir dans la vie ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_171',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Certaines préfèrent ne plus regarder les actualités télévisées. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_172',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
De jeunes Canadiens choisissent d’habiter chez leurs parents, parce qu’ils s’y sentent confortables. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_173',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
L’utilisation d’Internet peut amener les personnes à se sentir seules ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_174',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, parmi les principaux enjeux actuels (humanitaire, social ou culturel), laquelle mérite d’être priorisée dans le monde actuel ? Justifiez .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_175',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Quelles sont les trois principales choses à réfléchir avant de se lancer dans un projet d’immigration au Québec ? Expliquez .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_176',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Les universités devraient-elles bénéficier de plus de financements ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_177',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Quelles expériences ou sites recommanderiez-vous à un étranger qui visite votre pays pour la première fois ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_178',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-ce que les bénéfices de vivre à l’étranger surpassent ses inconvénients ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_179',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Quelles mesures pourrait-on prendre pour inciter les personnes à faire davantage de sport ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_180',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Les employés sont-ils surtout motivés par leur salaire ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_181',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis chargé(e) de l’accueil dans un centre de loisirs. Vous voulez vous inscrire à une activité (sport, dessin, sculpture, etc.). Vous me demandez des informations sur les cours proposés (tarifs, heures, matériel à prévoir, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_182',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je viens de rejoindre l’équipe et nous nous rencontrons pour la première fois. Vous me posez des questions pour mieux me connaître (poste, situation familiale, loisirs, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_183',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Vous êtes nouvellement installé(e) au Canada et vous voulez faire de nouvelles rencontres. Vous me posez des questions sur les moyens de se faire des amis (endroits, activités, événements, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_184',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis installé(e) au Canada mais je vais changer de logement, alors je mets mes affaires en vente. Vous venez d’arriver au Canada et vous cherchez des meubles pour votre logement. Vous me demandez des informations sur les objets à vendre (meubles, électroménager, prix, état, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_185',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Nous sommes amis(e)s. J’ai fêté mon anniversaire récemment, mais vous n’avez pas pu être présent(e). Vous me demandez des informations sur le déroulement de la fête (activités, invités, cadeaux, ambiance, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_186',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre ami(e) et je vous invite à assister à un concert avec moi. Vous souhaitez en savoir plus et vous me posez des questions sur le concert (genre de musique, endroit, date, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_187',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre ami(e). J’ai participé à un atelier de cuisine. Vous êtes intéressé(e) à y assister. Vous me demandez des informations sur cet atelier (tarifs, horaires, programme, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_188',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre collègue de travail. Vous venez d’arriver à Toronto. Vous voulez organiser votre anniversaire dans un bon restaurant. Vous me posez des questions concernant les restaurants en ville (style culinaire, prix, ambiance, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_189',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre voisin(e). Vous venez de vous installer à Edmonton. Vous désirez inscrire vos enfants à l’école. Vous me demandez des renseignements sur les écoles du quartier (emplacement, enseignants, activités, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_190',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je fais partie du service des transports en commun de la ville. Vous venez d’arriver ici. Vous souhaitez vous renseigner et vous me posez des questions sur les moyens de transport, les prix, les horaires, etc .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_191',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) collègue. Je vous offre deux billets pour un spectacle parce que je ne peux finalement pas y assister. Vous me posez des questions pour savoir si ce spectacle peut vous intéresser (date, endroit, type de spectacle, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_192',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Je vais bientôt partir vivre à l’étranger et je veux vendre mes meubles (table, chaises, télévision, canapé, etc.) avant mon départ. Vous me posez des questions pour obtenir des informations sur ces meubles (prix, état, taille, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_193',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Vous venez d’arriver au Québec et vous voulez prendre un rendez-vous chez un médecin. Vous me posez des questions pour avoir des informations sur les médecins de la ville (adresse, prix, spécialités, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_194',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je travaille dans un bureau de tourisme au Québec. Vous voulez visiter un parc à thème (aquarium, zoo, réserve naturelle, etc.). Vous me posez des questions pour avoir des informations (horaires, prix, restaurants, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_195',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans une agence de location de voitures au Québec. Vous voulez louer une voiture pour vos vacances. Vous me posez des questions pour obtenir des informations (prix, conditions de location, documents nécessaires, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_196',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre collègue. Vous venez d’intégrer l’entreprise et vous voulez mieux la connaître. Vous souhaitez obtenir des détails sur l’organisation, l’ambiance, la cantine, etc .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_197',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) et je vous propose de venir à une célébration. Vous êtes nouvellement arrivé(e) au Québec. Vous me demandez des précisions sur l’organisation (horaire, cadeau, habits, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_198',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis à la réception du club de sport près de chez vous. Vous souhaitez pratiquer une activité mais vous n’avez pas encore choisi. Vous me demandez des informations sur les sports disponibles (horaires, tarifs, équipement, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_199',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis à la réception d’un musée. Vous voulez venir le découvrir avec vos amis. Vous me demandez des informations pour préparer la visite (horaires, tarifs, visites guidées, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_200',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Nous travaillons ensemble. Vous voulez organiser un week-end et je vous recommande une ville que je connais. Vous me demandez des informations (logement, restaurants, sites à découvrir, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_201',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) francophone. Vous avez pour mission de préparer un article à propos d’un spectacle pour le bulletin de votre association culturelle francophone. Vous voulez trouver des idées et vous m’interrogez sur les spectacles que j’ai aimés (coût, type, lieu, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_202',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) collègue et je connais bien la ville de Montréal. Vous allez y séjourner une semaine pour des raisons professionnelles. Vous me demandez des précisions sur les transports publics (heures, prix, organisation, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_203',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre enseignant de français. Notre école de langues met en place un jeu pour les étudiants. Vous me demandez des informations pour en savoir davantage sur son organisation (règles, prix, modalités, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_204',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre supérieur. Notre entreprise vous offre une opportunité de travail à l’étranger. Avant de prendre votre décision, vous désirez en savoir davantage. Vous m’interrogez sur les détails du poste (missions, salaire, bénéfices, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_205',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Vous souhaitez faire une sortie ce soir, mais vous ne savez pas encore quoi faire. Nous en discutons entre amis et vous me posez des questions pour choisir une activité (endroit, transport, prix, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_181',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
De nos jours, certaines personnes décident de vivre sans téléphone portable. Quel est votre avis ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_182',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, doit-on donner une éducation différente aux filles et aux garçons ? Pour quelles raisons ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_183',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’on devrait interdire les jeux d’argent et de hasard ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_184',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pour quelles raisons quelqu’un déciderait-il de s’installer à l’étranger ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_185',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’un animal de compagnie peut être positif pour une personne âgée ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_186',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Certaines personnes préfèrent vivre sans se servir de la technologie (téléphone, Internet, ordinateur). Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_187',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
De nombreuses personnes se tournent vers la chirurgie esthétique pour sembler plus jeunes. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_188',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Obtenir un emploi quand on est jeune peut poser plus de difficultés. Êtes-vous d’accord ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_189',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Faut-il forcer les enfants à faire du sport ? Qu’en pensez-vous ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_190',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
La croissance du tourisme peut détériorer certaines régions. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_191',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
À votre avis, est-il préférable que tous les employés d’une entreprise gagnent le même salaire ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
);

INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
(
  'expression_orale',
  3,
  'EO_T3_192',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que le gouvernement devrait interdire la vente de cigarettes et d’alcool ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_193',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, est-il possible d’être heureux sans avoir d’amis ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_194',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que l’exploration de l’espace est trop chère et qu’elle n’est pas nécessaire ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_195',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’il serait préférable d’interdire l’utilisation des téléphones portables aux enfants ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_196',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
La gentillesse garantit-elle à chaque fois l’écoute et le respect des autres ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_197',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il possible de se sentir heureux en restant célibataire ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_198',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’il soit nécessaire de réserver une journée pour les droits des femmes ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_199',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
La télévision est-elle un bon outil pour acquérir des connaissances ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_200',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’il soit nécessaire d’apprécier son métier pour réussir professionnellement ? Expliquez .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_201',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Faut-il développer encore plus le secteur du tourisme dans votre pays ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_202',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
S’installer à l’étranger nécessite beaucoup de courage. Partagez-vous cet avis ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_203',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
À votre avis, quelles raisons peuvent amener quelqu’un à exercer un emploi à l’étranger ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_204',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Faut-il absolument vivre dans un pays pour bien comprendre sa culture ? Justifiez .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_206',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Je dois m’absenter et vous vous occupez de mon animal. Vous me demandez des renseignements (dates, routines, soins nécessaires, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_207',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Chaque semaine, je fais appel à un(e) baby-sitter. Vous souhaitez trouver quelqu’un pour votre enfant et vous me demandez des informations sur cette personne (horaires, prix, compétences, activités proposées, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_208',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Je fais partie d’une agence qui propose des balades en forêt autour de Toronto. Vous voulez y participer et vous me demandez des informations (parcours, tarifs, niveau demandé, participants, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_209',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e)s. Vous venez de vous installer dans l’immeuble et vous souhaitez en savoir plus sur la vie dans l’immeuble (résidents, règlement, parties communes, ambiance, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_210',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je fais partie d’une association franco-canadienne. Vous comptez vous installer au Canada et et vous me demandez des renseignements sur le mode de vie des Canadiens (emploi, activités, logement, coutumes, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_211',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) du Québec. Vous venez de vous installer au Québec. Vous allez assister à un mariage au Québec et vous me demandez des informations sur le déroulement (cérémonie, invités, cadeaux, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_212',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Je m’absente pour les vacances et vous prenez soin de mon chien pendant mon absence. Vous me demandez des informations pour bien vous en occuper (alimentation, soins, sorties, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_213',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) responsable. Vous allez participer à une formation de deux semaines au Québec dans le cadre professionnel. Vous me demandez des renseignements sur le stage (logement, déplacements, emploi du temps, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_214',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Vous êtes récemment arrivé(e) dans le quartier et vous cherchez des idées pour sortir le soir. Vous me demandez des informations sur les différentes options (endroits, activités, prix, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_215',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Vous possédez un appartement et vous souhaitez trouver un locataire. Mon logement vous attire et vous voulez le louer. Vous me demandez des renseignements pour décider si ma candidature est adaptée (profession, garanties, famille, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_216',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis l’un(e) de vos voisin(e)s. Vous avez récemment emménagé dans la résidence et nous nous rencontrons dans l’ascenseur. Vous me demandez des informations sur le quartier (les voisins, les commerces, les activités, l’atmosphère, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_217',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je travaille dans une agence immobilière. Vous cherchez à réserver un chalet au bord de la mer pour vos vacances. Vous me demandez des informations (tarif, installations, dates libres et les conditions, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_218',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis l’un(e) de vos voisin(e)s. Vous êtes récemment arrivé(e) au Canada et vous souhaitez inscrire vos enfants dans une école. Vous me demandez des renseignements (niveaux, matières proposées, horaires, coûts, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_219',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) collègue. Je vous offre une chambre dans une colocation et vous êtes intéressé(e). Vous me demandez des renseignements concernant l’appartement (prix du loyer, nombre de pièces, colocataires, règles, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_220',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis à l’accueil d’un centre de danse. Vous voulez vous inscrire à des cours. Vous me demandez des informations (styles de danse, horaires, prix, niveaux, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_221',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis enseignant de guitare. Vous êtes intéressé(e) par mes leçons. Vous me interrogez sur le déroulement des cours (emplois du temps, prix, genres musicaux, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_222',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre collègue. Je loue ma maison pendant les vacances d’été. Vous souhaitez la louer et vous me renseignez sur le logement (nombre de chambres, environnement, tarif, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_223',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Je travaille au sein d’une association. Vous souhaitez en savoir plus et vous me interrogez sur ce que je fais (rôle, tâches, temps de travail, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_224',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) collègue. Vous commencez aujourd’hui dans une entreprise canadienne. Vous me interrogez sur l’organisation de l’entreprise (équipes, structure, repas, etc. ).

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_225',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) au secrétariat d’une université à Calgary. Vous souhaitez suivre des cours de langues pour adultes. Vous me demandez des informations sur les formations offertes (langues, coûts, emplois du temps, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_226',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre ami(e). Vous venez d’arriver au Canada et vous recherchez un logement. Je peux vous proposer une chambre à partager dans mon appartement. Posez-moi vos questions .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_227',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre ami(e). J’ai récemment commencé un nouveau poste. Posez-moi des questions sur cette expérience professionnelle .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_228',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis l’assistante de votre médecin de famille. Comme il est en vacances et qu’un autre médecin le remplace, vous pouvez me poser des questions pour obtenir des informations .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_229',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre ami(e) et je possède un blog. Vous voulez voyager et vous cherchez des conseils pour créer un blog. Posez-moi toutes vos questions .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_230',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis votre voisin(e). Vous venez d’arriver au Canada et vous voulez préparer l’anniversaire de votre conjoint(e), vous me poser des questions.

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_231',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je produis des fruits et légumes biologiques. Je les vends directement aux particuliers. Vous êtes intéressé(e) et vous me posez des questions pour connaître les prix, les produits, la livraison, etc .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_232',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) et je m’engage dans une association qui soutient les personnes âgées. Vous souhaitez en savoir plus et vous me posez des questions (type d’activités, public concerné, comment s’inscrire, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_233',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) collègue. J’ai passé dix ans au Canada. Vous pensez partir vivre à Ottawa. Vous me posez des questions sur mon expérience d’intégration (se loger, travailler, s’adapter à la culture, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_234',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). J’ai visité le zoo le week-end dernier. Vous pensez y aller en famille. Vous me posez des questions pour préparer votre sortie (jour, animaux à voir, prix, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_235',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans une agence de voyages. Vous souhaitez partir au Canada pour profiter des sports d’hiver. Vous me posez des questions (activités, hébergements, tarifs, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_236',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) et je dois m’absenter pendant le week-end. Je vous demande de veiller sur ma fille de 3 ans. Vous la connaissez un peu, mais vous n’êtes pas très proches. Je vous donne des explications pour bien s’occuper d’elle. Vous me demandez des informations sur ses habitudes (repas, jeux, sommeil, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_237',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) collègue et je vous suggère d’assister ensemble à un spectacle. Vous me demandez des informations sur le spectacle (type, lieu, heure) et sur les détails pratiques de la sortie (transport, participants, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_238',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) au service culturel de la mairie. Vous voulez vous informer sur les différentes activités culturelles de la ville (activités sportives, ateliers, musées, spectacles, etc.). Vous m’interrogez sur les détails pratiques (nature des activités, fréquence, tarifs, durée, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_239',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans une agence de voyages. Vous êtes client(e) et vous cherchez des idées pour un voyage au Canada. Vous m’interrogez afin d’obtenir des détails (lieux à visiter, prix, logement, activités, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_240',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Vous êtes en déplacement en voiture au Canada et votre véhicule ne fonctionne plus. Vous appelez votre assurance afin de connaître les services proposés (assistance, réparations, retour, etc.). Je suis l’agent d’assurance chargé de vous informer .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_205',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
De nos jours, est-il possible de changer de métier à tout âge ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_206',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il possible de vivre dans un pays sans connaître sa langue ? Quel est votre point de vue ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
);

INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
(
  'expression_orale',
  3,
  'EO_T3_207',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que la croissance du tourisme est en contradiction avec la protection de la nature ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_208',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Faut-il que les parents surveillent les amis de leurs enfants ? Quel est votre point de vue ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_209',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Offrir la gratuité des transports en commun dans les villes est-il une solution intéressante ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_210',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il approprié d’offrir un téléphone portable à un enfant ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_211',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Faut-il que les transports en commun soient accessibles gratuitement à tout le monde ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_212',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Faut-il réduire le temps de travail pour vivre plus pleinement ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_213',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il plus plaisant de vivre à la campagne qu’en ville ? Êtes-vous d’accord ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_214',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-ce que voyager est uniquement réservé pour les personnes riches ? Êtes-vous d’accord ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_215',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
S’installer à l’étranger pour travailler ne présente pas de difficultés. Êtes-vous d’accord ? Expliquez pourquoi .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_216',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Le stress peut avoir des effets positifs et encourager les personnes à agir. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_217',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il important d’adopter une attitude autoritaire envers ses enfants ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_218',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Que pensez-vous de la qualité de la nourriture dans votre pays ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_219',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
La télévision contribue à l’éducation des enfants. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_220',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il possible de se fier aux rendez-vous médicaux à distance ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_221',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Doit-on apprendre les technologies à l’école dès le plus jeune âge ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_222',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Existe-t-il des professions plus utiles que d’autres ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_223',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
La consommation d’objets comme les vêtements et les téléphones est-elle excessive ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_224',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Les entreprises devraient-elles réduire le télétravail pour leurs salariés ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_225',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Vaut-il mieux immigrer seul(e) ou avec sa famille ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_226',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que nos habitudes alimentaires se transforment au fil des années ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_227',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’il faille maîtriser son métier pour progresser dans la hiérarchie d’une entreprise ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_228',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
La diversité dans les écoles aide-t-elle tous les élèves à mieux s’épanouir ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_229',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Les employeurs devraient-ils offrir des formations à leurs employés tout au long de leur carrière ? Est-ce bénéfique pour tous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_230',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
De plus en plus de gens choisissent de devenir végétariens. Que pensez-vous de ce régime alimentaire ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_231',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Peut-on vraiment tout acheter sur Internet ? Qu’en dites-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_232',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Le salaire est-il le facteur principal dans un emploi ? Êtes-vous d’accord ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_233',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Peut-on considérer les membres de la famille comme nos meilleurs amis ? Expliquez pourquoi .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_234',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
La vie en ville est-elle plus facile pour les personnes âgées que la vie à la campagne ? Êtes-vous d’accord ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_235',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Tous les étés, les magazines publient des recommandations pour perdre du poids. À votre avis, ces informations sont-elles efficaces et crédibles ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_236',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon certains, des personnes très différentes ne peuvent pas garder une amitié durable. Êtes-vous d’accord ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_237',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Voyager à l’étranger peut transformer une personne. Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_238',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Les outils digitaux aident à économiser du temps dans la vie de tous les jours. Partagez-vous cet avis ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_239',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, est-ce simple de créer des amitiés lorsqu’on arrive dans un pays étranger ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_241',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis chargé(e) de l’accueil dans un centre d’information dédié aux associations de la ville. Vous souhaitez devenir bénévole dans une association proche de chez vous. Vous me demandez des renseignements (domaines d’action, activités, personnes concernées, organisation du temps, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_242',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis enseignant(e) de français. Vous êtes récemment arrivé(e) au Canada et vous souhaitez prendre des cours individuels. Vous me demandez des informations sur mon expérience professionnelle (parcours, méthodes d’enseignement, prix, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_243',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e) du Canada. Je rentre d’un excellent séjour à la montagne. Vous souhaitez organiser un voyage similaire et vous me demandez des informations sur mon expérience (destination, logement, activités, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_244',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Je participe à des cours de théâtre toutes les semaines. Vous voulez vous inscrire et vous me demandez des détails (horaires, prix, fonctionnement, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_245',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Vous êtes récemment arrivé(e) au Québec. Je suis un(e) voisin(e) et je vous propose un apéritif de bienvenue. Lors de cette rencontre, vous me demandez des détails pour découvrir la vie du quartier (habitants, commerces, activités, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_246',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Vous êtes récemment arrivé(e) dans ma ville. Vous cherchez à organiser une sortie économique et vous me demandez des renseignements (endroits, activités, transports, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_247',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Je dispose d’une maison de vacances en bord de mer que je propose à la location. Vous souhaitez en savoir plus et vous me demandez des précisions (aménagements, lieu, tarif, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_248',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans une boutique de mobilier. Vous désirez recevoir un meuble et vous me demandez des informations sur la livraison (coût, délai, moyen utilisé, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_249',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Dans la salle d’attente, nous attendons le train qui a pris du retard et nous discutons un peu. Je vous parle de mon intérêt pour la montagne, et vous me demandez des détails (régions, randonnées, équipement, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_250',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Nous participons à une soirée et nous venons de faire connaissance. Je vous mentionne que je reviens tout juste d’un séjour, et vous me demandez des informations (période, endroits visités, avis, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_251',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis employé(e) dans un restaurant. Vous souhaitez préparer un repas d’anniversaire pour votre meilleur(e) ami(e). Interrogez-moi sur les prestations du restaurant (menus, tarifs, horaires, disponibilités, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_252',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Nous travaillons ensemble. Je propose à la vente des habits pour enfants de seconde main. Vous souhaitez en savoir plus. Interrogez-moi sur ces articles (tailles disponibles, tarifs, quantité, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_253',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) voisin(e). Je propose des cours de cuisine. Vous souhaitez en savoir plus. Interrogez-moi afin de savoir comment se déroulent les cours (prix, recettes, participants, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_254',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). J’ai vécu une croisière en bateau. Vous souhaitez en organiser une. Interrogez-moi pour en savoir plus (prix, activités, services proposés, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  2,
  'EO_T2_255',
  'Tâche 2 — Exercice en interaction (avec préparation) (2 min de préparation • 3 min 30 d’échange)

Sujet :
Je suis un(e) ami(e). Je souhaite vendre mon logement. Vous voulez en savoir plus. Interrogez-moi afin d’obtenir des renseignements (pièces, équipements, tarif, etc.) .

Consignes :
• Temps de préparation : 2 minutes
• Durée de l''échange : environ 3 minutes 30',
  210,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_240',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous qu’Internet joue un rôle bénéfique dans l’éducation des enfants ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_241',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
La plupart des gens essaient-ils de paraître plus jeunes que leur âge ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
);

INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
(
  'expression_orale',
  3,
  'EO_T3_242',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Le tourisme permet-il à un pays de se développer et de progresser économiquement ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_243',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Les jeux vidéo constituent-ils un danger pour les joueurs ? Expliquez pourquoi .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_244',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il nécessaire d’avoir des diplômes pour réussir dans sa carrière professionnelle ? Justifiez votre réponse .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_245',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
De quelle manière les entreprises peuvent-elles faciliter l’intégration des nouveaux employés ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_246',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que le fait de résider dans plusieurs pays puisse améliorer les perspectives professionnelles ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_247',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Quelle était votre matière préférée à l’école ? Pour quelle raison ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_248',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Quelles leçons ou matières devraient avoir plus de place dans les programmes scolaires ? Pourquoi ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_249',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Selon vous, est-il préférable d’avoir une grande famille ou de vrais amis ? Expliquez .

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_250',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Peut-on vivre sans utiliser de médicaments ? Partagez-vous cette opinion ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_251',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Les parents devraient-ils permettre à leurs enfants d’être sur les réseaux sociaux ? Êtes-vous d’accord ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_252',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Les entreprises doivent-elles accepter que les employés se reposent au travail ? Êtes-vous d’accord ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_253',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Pensez-vous que chacun puisse assumer un rôle de responsable, par exemple dans un service, un magasin ou une association ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
),
(
  'expression_orale',
  3,
  'EO_T3_254',
  'Tâche 3 — Expression d''un point de vue (sans préparation) (Sans préparation • 4 min 30)

Sujet :
Est-il pratique de continuer à vivre avec ses parents après l’âge de 25 ans ? Qu’en pensez-vous ?

Consignes :
Présentez votre point de vue de manière structurée et argumentée sur ce sujet

• Durée de l''exposé : environ 4 minutes 30 (sans préparation)',
  270,
  true
);

