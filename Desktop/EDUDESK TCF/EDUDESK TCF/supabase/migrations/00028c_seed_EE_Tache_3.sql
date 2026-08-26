-- ==========================================================
-- SEED : TÂCHE 3 EXPRESSION ÉCRITE (350 sujets authentiques)
-- ==========================================================

DELETE FROM public.taches WHERE epreuve = 'expression_ecrite' AND numero_tache = 3;

INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
(
  'expression_ecrite',
  3,
  'EE_T3_001',
  'Thème du débat : « Distributeurs dans les lycées : avantages et inconvénients »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Certains estiment que l’installation de distributeurs automatiques dans les lycées est un atout. Ils permettent aux élèves d’avoir un accès rapide à des boissons et en-cas, notamment lorsqu’ils n’ont pas le temps de passer à la cantine. De plus, ces distributeurs peuvent être approvisionnés en options saines comme des jus de fruits sans sucre et de l’eau.

Document B :
D’autres considèrent que ces distributeurs favorisent une consommation excessive de produits sucrés et contribuent à des problèmes de santé comme l’obésité et le diabète. Ils pensent que les écoles devraient encourager des habitudes alimentaires plus saines et éviter ces installations qui peuvent inciter à une mauvaise alimentation.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_002',
  'Thème du débat : « École privée : quels enjeux ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
En France, les écoles privées ont accueilli un nombre plus important d’élèves lors de la dernière rentrée. Leur popularité n’est pas uniquement due aux résultats obtenus par les élèves. C’est surtout leur réputation qui attire les familles. De nombreux parents considèrent que l’encadrement y est meilleur, que les élèves sont davantage surveillés et que les enseignants sont plus impliqués. Ils sont aussi rassurés par la composition des classes, souvent constituées d’élèves provenant de milieux favorisés. Cela s’explique notamment par le coût des études dans ces établissements, alors que l’enseignement public est gratuit.

Document B :
Les collèges privés accueillent peu d’élèves provenant de milieux défavorisés. Les frais de scolarité représentent un obstacle pour une partie de la population. Cette distinction entre écoles publiques et privées limite la diversité sociale au sein des établissements. Ainsi, les jeunes scolarisés dans le privé ont peu de contacts avec des élèves ayant des conditions de vie différentes. Ce système tend à reproduire les inégalités existantes et à renforcer le sentiment d’être mis à l’écart chez certains jeunes.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_003',
  'Thème du débat : « Utilisation Des Nouvelles Technologies Dans Les Écoles : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Adam : Je suis persuadé que l''intégration des nouvelles technologies dans les écoles est essentielle pour préparer les élèves à l''avenir numérique. L''utilisation des tablettes et ordinateurs motive les élèves et enrichit leur expérience d''apprentissage en leur donnant accès à diverses ressources, favorisant ainsi leur créativité et leur autonomie.

Document B :
Inès : Je reste dubitative face à l''utilisation excessive des technologies dans l''éducation. Cela peut limiter les interactions humaines et entraîner une dépendance aux écrans. À mon avis, les méthodes traditionnelles et le contact direct entre enseignants et élèves sont essentiels pour un développement équilibré des compétences des jeunes.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_004',
  'Thème du débat : « Cuisiner pour le plaisir ou comme métier ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les passionnés de cuisine arrivent à préparer quelques plats, mais ils manquent généralement des techniques et de l’expérience des chefs. Maîtriser l’art culinaire nécessite apprentissage et pratique approfondie.

Document B :
Grâce aux réseaux sociaux et aux cours en ligne, certains autodidactes se sont distingués. Le parcours d’une passionnée devenue cheffe et auteure de livres de cuisine démontre qu’il est possible de réussir autrement que par la voie classique.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_005',
  'Thème du débat : « L’interdiction des voitures en ville »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Face à des niveaux de pollution très élevés observés dans plusieurs régions du monde, certaines villes ont décidé d’interdire la circulation des voitures dans les centres urbains. La capitale norvégienne, Oslo, a récemment choisi cette mesure et en tire un bilan positif, estimant qu’elle profite à tous. Avec le temps, les accidents diminueront, la consommation de pétrole reculera et la qualité de l’air s’améliorera.

Document B :
De nombreuses villes lancent des projets visant à interdire les voitures en milieu urbain sans disposer des moyens et des infrastructures indispensables pour assurer la réussite de ce changement. Certes, la réduction du nombre de voitures permet de diminuer la pollution, mais en contrepartie, il est nécessaire de prévoir de grands parkings, de développer davantage les transports en commun (métros et bus) et d’accorder des autorisations spéciales à certains professionnels (police, services d’urgence, livreurs, etc.).',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_006',
  'Thème du débat : « Lecture et enfants : encourager sans forcer »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Obliger les enfants à lire n’est pas une bonne solution. Lire est une pratique particulière. Quand un enfant aime le sport, on ne le contraint pas, on essaie de le motiver. Il en va de même pour la lecture, selon Laurence T., pédopsychiatre et experte de l’enfance. Elle affirme que « l’amour de la lecture ne peut pas être imposé ».

Document B :
Lire avec ses enfants est une activité agréable et bénéfique. Elle contribue au développement des enfants, car une lecture régulière leur permet d’apprendre de nouveaux mots. Elle les aide également à mieux écouter et à se familiariser avec les mots écrits. Ce moment est idéal pour partager du plaisir en famille, de manière détendue et ludique. Les parents doivent essayer de lire des histoires à leurs enfants dès leur jeune âge, même après une journée fatigante. Cinq à dix minutes par jour sont suffisantes pour leur donner le goût de la lecture durablement.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_007',
  'Thème du débat : « Femmes et hommes au travail »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Dans certaines régions, comme le Québec, l’égalité entre les femmes et les hommes est une réalité. Beaucoup de femmes occupent désormais des postes à responsabilité et travaillent dans des domaines traditionnellement masculins, tels que le bâtiment ou la gestion d’entreprise. Avec les lois sur l’égalité et le changement des mentalités, les femmes ont aujourd’hui accès aux mêmes métiers que les hommes, sans subir de discrimination.

Document B :
Même si des efforts sont faits pour atteindre la parité, des inégalités demeurent. Par exemple, certains métiers sont encore très féminisés, comme celui de sage-femme ou d’assistante maternelle. De plus, certaines personnes estiment que les femmes doivent rester à la maison pour s’occuper des enfants plutôt que travailler dans des métiers exigeants ou à responsabilité. Il reste donc beaucoup à faire pour changer les mentalités et garantir les mêmes chances aux femmes et aux hommes.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_008',
  'Thème du débat : « Les vols low-cost : avantages et limites »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Je voyage souvent avec des compagnies aériennes à petit prix. Les compagnies low-cost proposent des billets beaucoup moins chers que les compagnies classiques. Parfois, cela me revient même moins cher que de voyager en voiture ou en train. Mais avec ces tarifs très bas, il y a forcément un inconvénient : aucun service n’est inclus à bord (pas de repas ni de boissons). À mon avis, ce type de vol n’est donc pas adapté aux longs trajets.

Document B :
Dernièrement, j’ai décidé d’arrêter de voyager avec les compagnies aériennes low-cost. Après mûre réflexion, ce choix m’a paru évident : les sièges sont inconfortables, les employés travaillent dans des conditions difficiles et les avions semblent parfois trop vieux pour garantir une bonne sécurité. Désormais, pour mes déplacements, je préfère utiliser la voiture ou le train, qui permet d’admirer de beaux paysages. Pour les longs trajets, je choisirai plutôt une compagnie aérienne classique.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_009',
  'Thème du débat : « Villes sans voitures : avantages et précautions »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
En raison de la pollution importante observée dans de nombreuses régions, certaines villes ont choisi d’interdire les voitures dans les zones urbaines. La ville d’Oslo, en Norvège, a appliqué cette mesure récemment et constate des effets positifs pour tous. Avec le temps, les accidents diminuent, la dépendance au pétrole est réduite et l’air devient plus sain.

Document B :
Beaucoup de villes lancent des projets visant à interdire la circulation automobile en centre-ville sans préparer les infrastructures indispensables. Certes, diminuer le trafic permettrait de réduire les bouchons, le stress et la pollution de l’air. Mais il est également important de prévoir de grands parkings, de renforcer les transports publics, et de donner des autorisations particulières à certains professionnels, comme les services d’urgence, la police ou les livreurs.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_010',
  'Thème du débat : « Repas livrés au bureau : avantages et limites »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Se faire livrer un repas au bureau est un moyen pratique de gagner du temps. On n’a pas besoin de sortir pendant la pause déjeuner, ce qui aide à finir le travail plus tôt. Chacun peut également choisir le repas qu’il souhaite, selon ses envies. Enfin, ce service est accessible à toute heure grâce à des restaurants ouverts en continu.

Document B :
Néanmoins, ce système présente des limites. En cas de nombreuses commandes, les livreurs peuvent être débordés, ce qui cause des retards et du stress. Pour vous, rester assis sans prendre une vraie pause peut fatiguer. Il est donc conseillé de faire une coupure, même brève, afin de rester performant.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_011',
  'Thème du débat : « Les menus sans viande dans les cantines scolaires »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
De plus en plus d’établissements scolaires intègrent des repas sans viande dans leurs menus, au moins deux fois par semaine. Certaines études ont démontré que les enfants consomment une quantité excessive de protéines animales. Pour des raisons de santé, les écoles privilégient des alternatives comme le soja, les céréales et les légumes, qui sont plus sains et bénéfiques pour la croissance des enfants. En outre, ces repas sont souvent plus économiques pour les familles. Cette mesure est généralement bien accueillie par les parents et les élèves.

Document B :
La suppression de la viande dans les menus scolaires ne fait pas l’unanimité. Pour certaines familles en difficulté, la cantine représente la seule opportunité pour leurs enfants de consommer de la viande, qui reste un aliment coûteux. Par ailleurs, les producteurs locaux de viande sont affectés économiquement par cette mesure. Enfin, bon nombre d’enfants préfèrent encore les plats à base de viande, trouvant que les steaks de soja manquent de saveur.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_012',
  'Thème du débat : « Transports en commun : bénéfices et contraintes »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La gratuité des transports en commun est une initiative très positive. Elle permet de réduire le trafic automobile et de limiter les bouchons. Elle contribue aussi à diminuer la pollution et les risques pour la santé liés à l’air. Dans ma ville, où les transports sont gratuits, on constate une hausse de leur utilisation. Cette mesure a également favorisé le commerce local, car les habitants se rendent plus facilement au centre-ville pour leurs achats.

Document B :
À mon avis, cette mesure n’est pas appropriée. D’abord, la gratuité des transports représente un coût élevé pour les villes, et certaines, comme Toulouse, ont d’autres priorités, par exemple l’aménagement des espaces verts. Ensuite, il vaudrait mieux améliorer la desserte des transports publics plutôt que de les rendre gratuits, car certains quartiers en sont mal équipés. Enfin, garder les transports payants encourage les usagers à mieux respecter les installations, puisqu’ils financent leur fonctionnement.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_013',
  'Thème du débat : « Cuisinier Amateur Ou Cuisinier Professionnel ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Réussir des recettes ne suffit pas pour être un véritable cuisinier. Une formation et une expérience approfondie sont essentielles pour maîtriser les techniques du métier.

Document B :
Certains passionnés de cuisine se forment grâce à internet et deviennent populaires sur les réseaux sociaux. L’histoire d’une amatrice devenue chef et auteure de livres de cuisine illustre ce parcours.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_014',
  'Thème du débat : « Étudiants et travail saisonnier »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Après une longue période à l’université, les vacances permettent aux jeunes de se détendre. Ils partent en voyage et profitent de l’été. Pourtant, certains étudiants préfèrent travailler au lieu de partir en vacances : garde d’enfants, service en restauration ou cueillette de fruits. Bien que ces emplois saisonniers aient des points positifs, ils limitent le temps libre des jeunes, qui manquent de repos, de loisirs et de moments en famille ou entre amis. De plus, ces travaux sont parfois difficiles, ennuyeux ou mal payés.

Document B :
Pour quelles raisons de nombreux étudiants travaillent-ils durant les vacances ? Cette expérience représente souvent une entrée dans la vie professionnelle : elle leur permet de développer le sens des responsabilités et de connaître un métier. Gagner de l’argent est aussi motivant. Certains étudiants travaillent pour ne plus dépendre financièrement de leurs parents et pour financer des loisirs ou des voyages. Pour d’autres, travailler l’été est indispensable pour payer les frais d’études ou le loyer.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_015',
  'Thème du débat : « Le rôle du travail »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Le travail occupe une place importante dans notre vie : dès l’enfance, on nous demande : « Que veux-tu devenir plus tard ? ». Même s’il peut apporter de la satisfaction, il est souvent source de fatigue et peut donner l’impression d’être coincé dans une routine. Aujourd’hui, beaucoup de personnes constatent un déséquilibre entre leur vie professionnelle et leur vie personnelle. Il devient nécessaire de réfléchir à la place du travail dans notre société. Certains pensent qu’en travaillant moins, on pourrait profiter de davantage de temps libre, être plus heureux et mieux vivre.

Document B :
Le travail fait partie de notre identité sociale. Lorsqu’on rencontre quelqu’un pour la première fois, on demande souvent : « Que faites-vous dans la vie ? », ce qui montre l’importance du travail dans la perception de soi. Selon le spécialiste Jean-Daniel Remond, la vie professionnelle contribue à se construire : elle permet de rencontrer des gens, de créer des réseaux personnels et professionnels, de se sentir utile et même de se faire des amis. Même si certains décident de quitter leur emploi, pour la plupart, travailler est essentiel pour exister. Le travail reste donc crucial pour l’équilibre personnel et collectif.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_016',
  'Thème du débat : « Les sévérité des parents envers les enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
À 22 ans, je vis toujours chez mes parents, qui restent très stricts avec moi malgré mon âge. Plus jeune, il m''était interdit de dormir à l''extérieur ou de rentrer après 21h. Aujourd’hui, bien que je puisse sortir plus tard, ma mère m’appelle sans cesse jusqu’à mon retour à la maison.

Document B :
Certains parents hésitent à être trop stricts, de peur que cela freine l’épanouissement et la personnalité de leurs enfants. Toutefois, céder à toutes leurs demandes peut avoir des conséquences négatives à l’âge adulte. Vivre en société implique le respect de certaines règles essentielles.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_017',
  'Thème du débat : « Caméras de surveillance à l''école : pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
À l''école où je travaille à Montréal, les caméras de surveillance sont largement présentes. Leur objectif est de dissuader les élèves de commettre des actes de violence. Les enseignants, les parents et la majorité des élèves les accueillent favorablement, car cela renforce la sécurité des enfants et crée un environnement propice à l''enseignement. Cependant, certains élèves expriment des préoccupations quant à leur vie privée.

Document B :
Je m''oppose à l''installation des caméras de surveillance dans nos écoles à Montréal. Les résultats obtenus dans d''autres pays utilisant ce système ne sont pas convaincants. Les individus mal intentionnés peuvent facilement contourner ces caméras très visibles. Pour résoudre les problèmes de discipline à l''école, il est préférable d''améliorer la communication entre enseignants, administration et élèves, et de faire respecter les règles scolaires par tous, plutôt que de dépendre des caméras.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_018',
  'Thème du débat : « Produits faits maison : avantages et limites »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Produire ses propres produits biologiques à domicile permet de maîtriser entièrement les ingrédients utilisés, offrant ainsi des alternatives plus saines et adaptées aux besoins individuels. Cela participe également à la réduction des déchets plastiques grâce à l’utilisation d’emballages réutilisables. De plus, cette démarche permet de réaliser des économies sur le long terme tout en développant des compétences créatives, favorisant un mode de vie plus durable.

Document B :
La fabrication de produits biologiques à domicile présente certains défis. Des erreurs dans la formulation peuvent affecter leur efficacité ou provoquer des irritations. Le temps et les efforts nécessaires pour sélectionner et préparer les ingrédients peuvent également représenter une contrainte. De plus, l’absence de garantie sur la sécurité et la stabilité des produits maison augmente le risque de contamination si les règles de conservation ne sont pas respectées. Enfin, le coût initial des ingrédients de qualité peut constituer un frein pour certains.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_019',
  'Thème du débat : « Chasse aux animaux : une pratique à soutenir ou à rejeter ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Sophie (28 ans) : « Je fais partie de ceux qui ne parviennent pas à comprendre comment on peut prendre plaisir à tuer des animaux. Je fais aussi partie de ceux qui ne saisissent pas comment on peut prétendre aimer la nature tout en contribuant à sa destruction. »

Document B :
Bernard (Journaliste de la FRM) : « La chasse est pratiquée pour diverses raisons : qu’il s’agisse de se nourrir, de commercer, de gérer la faune, de protéger la propriété, de faire de l’exercice, de se divertir ou de chercher du prestige. »',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_020',
  'Thème du débat : « Les Produits Faits Maison : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Fabriquer vos propres produits biologiques à la maison offre un contrôle total sur les ingrédients, garantissant des options plus saines et personnalisées. Cela contribue également à réduire les déchets plastiques grâce à des emballages réutilisables. De plus, vous économiserez de l’argent à long terme et développerez des compétences créatives, favorisant ainsi un mode de vie plus durable.

Document B :
Cependant, la fabrication de produits biologiques à domicile comporte des risques. Les erreurs de formulation peuvent entraîner des produits inefficaces ou irritants. De plus, le temps et les efforts nécessaires pour trouver et préparer les ingrédients peuvent être contraignants. Il y a également un manque de garantie de sécurité et de stabilité des produits faits maison, avec un risque accru de contamination bactérienne si les produits ne sont pas correctement conservés. Enfin, le coût initial élevé pour l’achat d’ingrédients de qualité peut être dissuasif pour certains.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_021',
  'Thème du débat : « Caméras de surveillance : sécurité ou limites ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
De nos jours, les caméras de surveillance se multiplient dans les villes. Elles sont appréciées par de nombreux Français, car elles apportent plus de sécurité. Selon une enquête, 75 % des personnes sont pour leur utilisation. La majorité accepte d’être filmée dans les espaces publics, mais pas dans les entreprises.

Document B :
Selon certaines recherches, la vidéosurveillance est onéreuse et peu performante. Les caméras sont souvent repérées, ce qui limite leur efficacité contre les infractions comme le vol ou la violence. En plus, leur utilisation demande des ressources humaines importantes. Une étude en Allemagne montre qu’il faut jusqu’à sept personnes pour surveiller une seule caméra.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_022',
  'Thème du débat : « Technologie et enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les élèves du primaire ont la possibilité d’utiliser la technologie pour chercher des vidéos liées à leurs leçons étudiés en classe ou pour s’exercer avec des jeux qui développent leurs compétences en mathématiques, en lecture et en saisie au clavier.

Document B :
Aujourd’hui, les technologies poussent les enfants à rester inactifs, ce qui inquiète beaucoup les parents. Cela limite les jeux créatifs, les échanges sociales directes et l’activité physique. Pourquoi ne pas encourager vos enfants à poser leurs appareils en essayant des activités ludiques ?',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_023',
  'Thème du débat : « Lecture et enfants : encourager sans forcer »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Un concours en ligne invite les participants à raconter leur plus belle fête.

Document B :
Vous participez à ce concours. Dans votre texte, vous racontez comment cette fête s’est déroulée (anniversaire, fête culturelle, etc.) et vous précisez ce que vous en retenez .',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_024',
  'Thème du débat : « Le rôle du travail »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous souhaitez organiser un week-end avec vos proches le mois prochain. Vous envoyez un message pour leur expliquer votre plan, en décrivant le lieu, le moyen de transport et les activités prévues .

Document B :
COURRIER DES LECTEURS 
 Partir un an à l’étranger et tout quitter : est-ce une bonne ou une mauvaise idée ?',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_025',
  'Thème du débat : « L''éducation des enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
« J''ai 19 ans et j''habite toujours chez mes parents. Je suis majeure et responsable mais mes parents restent sévères avec moi. Jusqu''à 18 ans, quand je sortais, je devais rentrer avant 20 h 00 et je n''avais pas le droit de dormir chez mes amies. Même si aujourd''hui j''ai le droit de rentrer plus tard, ma mère s''inquiète encore. Elle m''appelle sur mon portable pour me demander où je suis et elle n''arrive pas à dormir avant mon retour. Mes parents me laissent quand même de la liberté mais je pense en avoir moins que les autres. » 
 Marion.

Document B :
Certains parents qui ne veulent pas être trop sévères ont peu de contrôle sur leurs enfants. Ils ont peur que leurs enfants, privés de leur liberté, soient malheureux et manquent de personnalité. Ces parents acceptent donc toutes les demandes de leurs enfants. Cette situation aura peu de conséquences pour les enfants jusqu''à l''adolescence. Cependant, à l''âge adulte, ils auront des difficultés pour vivre en société car ils auront du mal à accepter les règles.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_026',
  'Thème du débat : « Les Relations Amicales Au Travail : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez passé une soirée agréable avec des amis en assistant à un spectacle (film, pièce de théâtre, concert, etc.) que vous avez adoré. Vous en parlez sur votre blog en expliquant ce qui vous a particulièrement marqué .

Document B :
Les amitiés entre collègues au travail peuvent être très avantageuses. Elles contribuent à instaurer un environnement de travail agréable et une atmosphère positive au sein de l’équipe. Avoir des amis parmi ses collègues permet de solidifier les relations professionnelles et d’instaurer un esprit de camaraderie. Cela peut améliorer la communication, favoriser une collaboration plus étroite et faciliter la résolution des problèmes. En outre, partager des moments conviviaux en dehors du bureau, comme des déjeuners ou des sorties, permet de renforcer les liens et de créer une dynamique de groupe forte.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_027',
  'Thème du débat : « Le rôle du travail »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Partir un an à l’étranger et tout quitter : est-ce une bonne ou une mauvaise idée ? 
 Exprimez votre opinion sur le site voyage.internaute.fr avec des exemples tirés de votre expérience personnelle .

Document B :
Le travail occupe une place importante dans notre vie : dès l’enfance, on nous demande : « Que veux-tu devenir plus tard ? ». Même s’il peut apporter de la satisfaction, il est souvent source de fatigue et peut donner l’impression d’être coincé dans une routine. Aujourd’hui, beaucoup de personnes constatent un déséquilibre entre leur vie professionnelle et leur vie personnelle. Il devient nécessaire de réfléchir à la place du travail dans notre société. Certains pensent qu’en travaillant moins, on pourrait profiter de davantage de temps libre, être plus heureux et mieux vivre.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_028',
  'Thème du débat : « Colocation : bénéfices et inconvénients »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous rédigez un article de blog pour montrer votre admiration envers une personne célèbre ou non. Vous décrivez ses actions et expliquez pourquoi elle vous inspire .

Document B :
La colocation offre de nombreux avantages. Partager un appartement avec d’autres permet de diminuer le loyer, les charges et les dépenses communes. Elle favorise également les rencontres et les échanges culturels. Habiter avec d’autres personnes permet de rencontrer des individus différents, de nouer des amitiés et de vivre des expériences intéressantes.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_029',
  'Thème du débat : « Cuisiner pour le plaisir ou comme métier ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous publiez un message sur un forum pour partager votre vécu et vos impressions dans l’apprentissage d’une langue étrangère.

Document B :
Les passionnés de cuisine arrivent à préparer quelques plats, mais ils manquent généralement des techniques et de l’expérience des chefs. Maîtriser l’art culinaire nécessite apprentissage et pratique approfondie.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_030',
  'Thème du débat : « Femmes et hommes : vers l’égalité »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
L’égalité entre les hommes et les femmes est indispensable pour construire une société juste. Elle permet aux femmes d’avoir les mêmes chances professionnelles que les hommes et d’obtenir un salaire équitable. Sur le plan social, elle encourage leur participation à la vie politique, économique et culturelle. Cette égalité favorise aussi le respect mutuel et aide à diminuer les discriminations et les préjugés.

Document B :
Malgré les avancées réalisées, certains problèmes restent présents. Les inégalités de salaire et de carrière existent encore dans plusieurs domaines. Les stéréotypes sociaux et culturels influencent toujours les choix professionnels et les attitudes. De plus, certaines femmes ont du mal à équilibrer travail et vie familiale. Enfin, les mesures pour favoriser l’égalité sont parfois insuffisantes ou mal mises en œuvre, ce qui freine les progrès.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_031',
  'Thème du débat : « Faire ses courses : entre grandes surfaces et commerces de proximité »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Faire ses courses au supermarché est avantageux, puisqu’on y trouve une grande diversité de produits au même endroit. Vous avez la possibilité de garer votre voiture et de passer d’un rayon à l’autre pour acheter ce dont vous avez besoin : fruits, légumes, fromages, viandes, boissons. De plus, plusieurs marques sont proposées pour chaque produit, avec des offres promotionnelles régulières.

Document B :
ASSOCIATION POUR LA DÉFENSE DES COMMERCES DE PROXIMITÉ',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_032',
  'Thème du débat : « Autorité parentale et autonomie des enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous revenez d’une journée passée à la campagne avec vos amis. Vous publiez un message sur votre forum pour partager votre expérience et décrire ce que vous avez aimé (activités, paysages, animaux, etc.) .

Document B :
Bientôt 22 ans, je vis encore chez mes parents. Bien que majeure, je subis toujours l’autorité de mes parents. Quand j’étais plus jeune, je ne pouvais pas passer la nuit ailleurs et devais rentrer avant 21h. Aujourd’hui, je peux rester dehors plus longtemps, mais ma mère ne cesse de téléphoner pour savoir où je suis.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_033',
  'Thème du débat : « L’interdiction des voitures en ville »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez effectué un séjour au Canada grâce à une agence de voyages. Rédigez un commentaire pour décrire l’expérience que vous avez vécue pendant ce voyage .

Document B :
Face à des niveaux de pollution très élevés observés dans plusieurs régions du monde, certaines villes ont décidé d’interdire la circulation des voitures dans les centres urbains. La capitale norvégienne, Oslo, a récemment choisi cette mesure et en tire un bilan positif, estimant qu’elle profite à tous. Avec le temps, les accidents diminueront, la consommation de pétrole reculera et la qualité de l’air s’améliorera.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_034',
  'Thème du débat : « Animaux de compagnie pour enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous faites partie d’une association qui soutient les personnes âgées. Écrivez un article pour un blog afin de raconter votre expérience et motiver d’autres personnes à s’engager .

Document B :
Donner un animal de compagnie à un enfant comporte de nombreux bienfaits, comme le montrent de nombreux psychologues. Pour les enfants qui n’ont pas de frères ou de sœurs, l’animal devient un compagnon et leur évite la solitude. Grâce à lui, l’enfant gagne en confiance et apprend que l’animal est un être vivant qui mérite attention et respect. Avec sa présence, l’enfant se sent en sécurité et peut devenir plus autonome sans l’aide constante de ses parents.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_035',
  'Thème du débat : « Vivre en colocation à l’âge adulte »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez découvert une ville que vous ne connaissiez pas auparavant. Vous souhaitez partager cette expérience. Vous publiez un message sur un site Internet consacré aux voyages. Vous racontez votre séjour et expliquez ce que vous avez aimé et ce que vous avez moins apprécié dans cette ville .

Document B :
La vie en colocation demande de bien s’entendre et de suivre des règles communes. On ne peut pas toujours mettre la musique à un volume élevé, inviter tous ses amis ou laisser la cuisine en désordre. Chaque personne a des comportements qui peuvent agacer les autres. Il est donc nécessaire d’établir des règles claires et de les respecter ensemble. Discuter avec ses colocataires lorsqu’un souci se présente est très important. Une bonne organisation et la communication permettent une colocation réussie.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_036',
  'Thème du débat : « La télévision dans la société : atouts et risques »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous souhaitez trouver un(e) camarade pour pour faire du sport. Vous écrivez un message sur le site des étudiants de votre école en précisant vos horaires libres .

Document B :
La télévision est un moyen de communication et de distraction très présent dans la société actuelle. Son impact est évident sur les personnes et sur la culture en général. Elle permet de transmettre des informations, de proposer différents programmes de divertissement et de diffuser la culture. Présente dans beaucoup de foyers, elle reste une source d’information et de loisirs accessible à tous. Grâce à sa large audience, la télévision joue un rôle essentiel dans le partage des connaissances et la sensibilisation aux questions sociales.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_037',
  'Thème du débat : « Ville ou campagne : deux modes de vie »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
À mon avis, vivre en ville permet de profiter de nombreuses activités de loisirs. Aller au cinéma, dîner au restaurant ou faire les magasins est très facile. Tout est à proximité, donc on n’a pas besoin de se déplacer longtemps pour se divertir. On peut marcher un peu ou prendre un taxi si nécessaire. La ville offre également une grande variété d’activités culturelles comme les musées, le théâtre ou l’opéra, pour que chacun trouve son bonheur.

Document B :
Il y a peu de temps, j’ai choisi de m’installer à la campagne après avoir quitté la ville, car je voulais vivre dans un environnement plus naturel et tranquille. Maintenant, plutôt que de sortir au restaurant ou dans les bars, j’invite mes amis à la maison pour partager un verre sur la terrasse ou organiser un barbecue. Le prix des logements a également été un élément important de mon choix. À la campagne, les maisons coûtent beaucoup moins cher qu’en ville. Avec le même budget, j’ai pu acheter une grande maison avec un jardin, ce qui n’aurait pas été possible en zone urbaine.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_038',
  'Thème du débat : « Devoirs à domicile : bienfaits et critiques »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
D’après certaines associations de parents d’élèves, les devoirs à domicile sont bénéfiques car ils permettent aux élèves de gérer leur temps seuls. Pour les parents, les devoirs représentent une occasion de se rapprocher de l’école chaque jour. Même si ce n’est pas toujours facile après une journée de travail, ils aiment ce temps passé avec leurs enfants, qui se sentent valorisés par l’intérêt que leurs parents leur montrent.

Document B :
Nous nous opposons depuis longtemps aux devoirs à la maison pour différentes raisons. Leur efficacité pour améliorer les résultats scolaires n’a jamais été prouvée de manière certaine. De nombreux parents n’ont pas le temps ou ne savent pas comment aider leurs enfants. De plus, les élèves qui ont compris le cours perdent du temps à refaire des exercices, tandis que ceux qui ne sont pas aidés restent en difficulté. C’est pour cela que nous estimons qu’il faudrait abolir les devoirs à domicile.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_039',
  'Thème du débat : « Villes et environnement : impacts et réalités »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
De nos jours, les villes s’agrandissent sans cesse. Ce phénomène affecte malheureusement l’environnement. Plus une ville se développe, plus ses effets sur la nature et sur l’homme sont néfastes. L’un des exemples les plus visibles est la déforestation. Les arbres et les espaces verts retiennent le carbone. Quand ils sont abattus pour construire des immeubles ou des routes, on détruit des zones importantes pour le stockage du carbone.

Document B :
Plus de la moitié des habitants de la planète vivent dans des villes, et dans les pays riches, huit habitants sur dix sont citadins. La vie urbaine constitue donc un enjeu écologique majeur. On affirme souvent que les villes actuelles ne respectent pas l’environnement et que leur développement augmente la pollution. Cependant, il faut relativiser : les villes ne sont pas toujours aussi polluantes qu’on l’imagine. Par exemple, un habitant de la ville consomme souvent moins d’énergie qu’une personne à la campagne.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_040',
  'Thème du débat : « Objets connectés : progrès ou danger ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les objets connectés rendent le quotidien plus pratique. Il s’agit d’appareils que vous contrôlez à distance à l’aide d’un téléphone ou d’Internet, par exemple le chauffage ou l’ouverture des portes. Les montres et bracelets connectés permettent également d’observer vos activités. Un programme peut mesurer vos pas afin de vous motiver à faire plus d’exercice. Leur rôle est particulièrement utile dans le secteur de la santé, car certains objets rappellent les consultations médicales ou la prise de médicaments.

Document B :
On pense qu’il existe environ 50 milliards d’objets connectés à travers le monde : alarmes, télévisions, caméras de sécurité, volets ou détecteurs de fumée. Toutefois, ce développement entraîne des risques liés à la sécurité. Un hacker peut contrôler un objet connecté en peu de temps. Par exemple, un cambrioleur pourrait vérifier, à l’aide de caméras connectées, si une maison est vide. Il est également possible de pirater le système d’un véhicule connecté et de le diriger à distance.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_041',
  'Thème du débat : « Les jeux vidéo : entre risques et bienfaits »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
De l’enfance jusqu’à l’adolescence, les enfants jouent souvent aux jeux vidéo et, avec le temps, cela peut provoquer des idées négatives et des comportements violents. Une étude récente réalisée auprès de jeunes de 9 à 18 ans qui jouent régulièrement montre que les jeux vidéo violents augmentent fortement l’agressivité. D’après Diego Gentil, ce phénomène serait inévitable, même avec un contrôle parental.

Document B :
On parle souvent des aspects négatifs des jeux vidéo, pourtant ils peuvent aussi avoir des effets positifs sur le cerveau et la santé en général. Par exemple, ils permettent de développer certaines capacités mentales comme l’attention, l’imagination et l’analyse. Cela s’explique par le fait que, lorsque vous jouez, vous devez réfléchir en permanence et résoudre des problèmes.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_042',
  'Thème du débat : « Faut-il mettre une photo sur son CV ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
De nos jours, certains candidats choisissent de mettre une photo sur leur CV, alors que d’autres préfèrent ne pas en mettre. Il faudrait interdire cette pratique pour éviter toute forme de discrimination ou d’injustice. Selon une étude menée par des spécialistes du recrutement, la photo n’a pas de réelle utilité. Les résultats indiquent que les employeurs accordent plus d’attention à l’expérience professionnelle (32 %) et aux diplômes (15 %) qu’au physique. Seuls 2 % des recruteurs commencent par regarder la photo. Cette donnée est surprenante, compte tenu de l’importance donnée à l’apparence par certaines personnes.

Document B :
L’utilisation d’une photo sur le CV est un sujet qui divise les recruteurs. Certains estiment que la photo aide à se faire une idée du candidat avant la rencontre. Elle peut également faciliter la mémorisation d’un candidat quand beaucoup de CV sont reçus. D’autres pensent que tout dépend du métier : pour les postes liés à l’accueil, par exemple, la photo peut être appropriée. Cependant, elle doit toujours être professionnelle pour créer une impression positive.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_043',
  'Thème du débat : « Aider les sans-abri : dons ou actions concrètes ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Chaque hiver, je consacre un peu de mon temps et de mon argent pour aider les personnes sans-abri qui souffrent du froid. Pour moi, il est important de penser à ceux qui sont dans le besoin. Je trouve essentiel de donner quelques dollars à ces personnes ou aux associations qui les soutiennent. De plus, cette action me fait sentir utile, au moins une fois par an ! C’est un geste de solidarité que chacun peut réaliser.

Document B :
Au lieu de donner de l’argent aux personnes défavorisées, il serait préférable de repenser notre façon de vivre. C’est pour cela que je préfère m’investir chaque jour dans une association de mon quartier, où je fais du bénévolat. Les sans-abri ont besoin d’un logement et d’un emploi, pas seulement d’argent. Il faut les aider à devenir indépendants. C’est l’objectif des associations qui aident les personnes dans la rue à trouver un travail. Donner de l’argent seul n’est pas utile, cela ne fait qu’apaiser notre conscience.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_044',
  'Thème du débat : « La télévision dans la société : atouts et risques »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La télévision est un moyen de communication et de distraction très présent dans la société actuelle. Son impact est évident sur les personnes et sur la culture en général. Elle permet de transmettre des informations, de proposer différents programmes de divertissement et de diffuser la culture. Présente dans beaucoup de foyers, elle reste une source d’information et de loisirs accessible à tous. Grâce à sa large audience, la télévision joue un rôle essentiel dans le partage des connaissances et la sensibilisation aux questions sociales.

Document B :
La télévision présente aussi certains aspects négatifs. Certains programmes peuvent transmettre des stéréotypes, des idées fausses ou des valeurs discutables. En outre, passer trop de temps devant la télévision peut diminuer le temps consacré à d’autres activités plus utiles, comme la lecture, les échanges sociaux ou le sport. Il est donc nécessaire de faire attention et de limiter le temps passé devant la télévision, surtout pour les enfants, afin de garder un bon équilibre entre apprentissage et loisirs.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_045',
  'Thème du débat : « Vivre en colocation à l’âge adulte »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La vie en colocation demande de bien s’entendre et de suivre des règles communes. On ne peut pas toujours mettre la musique à un volume élevé, inviter tous ses amis ou laisser la cuisine en désordre. Chaque personne a des comportements qui peuvent agacer les autres. Il est donc nécessaire d’établir des règles claires et de les respecter ensemble. Discuter avec ses colocataires lorsqu’un souci se présente est très important. Une bonne organisation et la communication permettent une colocation réussie.

Document B :
Vivre en colocation à l’âge adulte ? C’est un choix pratique pour avoir un logement plus spacieux à moindre coût. Vous avez uniquement votre chambre, tandis que la cuisine, le salon et la salle de bain sont communs. Pourtant, il est possible de vivre dans une maison avec jardin ou un grand appartement en centre-ville. En divisant le loyer et les frais avec vos colocataires, vous dépensez beaucoup moins que pour un logement individuel. Ainsi, malgré le partage des espaces, la colocation permet d’accéder à des logements plus abordables.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_046',
  'Thème du débat : « Animaux de compagnie pour enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Donner un animal de compagnie à un enfant comporte de nombreux bienfaits, comme le montrent de nombreux psychologues. Pour les enfants qui n’ont pas de frères ou de sœurs, l’animal devient un compagnon et leur évite la solitude. Grâce à lui, l’enfant gagne en confiance et apprend que l’animal est un être vivant qui mérite attention et respect. Avec sa présence, l’enfant se sent en sécurité et peut devenir plus autonome sans l’aide constante de ses parents.

Document B :
De nombreux enfants demandent un jour ou l’autre à leurs parents un animal, souvent un chien ou un chat. Même si vous souhaitez faire plaisir à votre enfant, il est important de bien réfléchir avant d’adopter un animal. Celui-ci devient un membre de la famille et implique un engagement sur plusieurs années. Avoir un animal coûte souvent cher et demande beaucoup de responsabilités. Ce n’est pas un jouet que l’on peut jeter quand l’enfant ne s’en occupe plus.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_047',
  'Thème du débat : « Faire ses courses : entre grandes surfaces et commerces de proximité »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Faire ses courses au supermarché est avantageux, puisqu’on y trouve une grande diversité de produits au même endroit. Vous avez la possibilité de garer votre voiture et de passer d’un rayon à l’autre pour acheter ce dont vous avez besoin : fruits, légumes, fromages, viandes, boissons. De plus, plusieurs marques sont proposées pour chaque produit, avec des offres promotionnelles régulières.

Document B :
ASSOCIATION POUR LA DÉFENSE DES COMMERCES DE PROXIMITÉ 
 L’initiative « Février sans supermarché » vise à limiter le pouvoir des supermarchés et à soutenir la survie des petits commerces en améliorant leurs ventes. Le principe est simple : ne pas faire ses courses dans les grandes surfaces durant un mois et privilégier les épiceries de quartier. Les clients en retirent des avantages, comme des produits plus frais et de qualité, ainsi que des moments d’échange avec leurs voisins.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_048',
  'Thème du débat : « Autorité parentale et autonomie des enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Bientôt 22 ans, je vis encore chez mes parents. Bien que majeure, je subis toujours l’autorité de mes parents. Quand j’étais plus jeune, je ne pouvais pas passer la nuit ailleurs et devais rentrer avant 21h. Aujourd’hui, je peux rester dehors plus longtemps, mais ma mère ne cesse de téléphoner pour savoir où je suis.

Document B :
Parfois, les parents ont peur d’être trop stricts avec leurs enfants. Ils redoutent qu’un excès d’autorité empêche leurs enfants de s’épanouir et nuise à leur personnalité plus tard. Même si, par amour, les parents acceptent toutes les demandes de leurs enfants, cela peut avoir des effets négatifs à l’âge adulte. En effet, vivre en société implique de respecter certaines règles.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_049',
  'Thème du débat : « Les maisons de retraite : deux visions différentes »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Je vis dans un pays où les maisons de retraite sont très rares. Ici, lorsqu’une personne âgée ne peut plus vivre seule, elle s’installe chez les plus jeunes, et en général, cela ne crée pas de grands problèmes. Pour nous, il est inhabituel de laisser nos parents ou grands-parents à des inconnus.

Document B :
Les maisons de retraite sont souvent mal perçues, pourtant elles sont une solution efficace pour les personnes âgées. Elles évitent l’isolement puisqu’on y trouve d’autres seniors. Elles proposent aussi des soins médicaux adaptés. De plus, elles sont pratiques et rassurantes pour les familles. Le seul problème est que leur prix reste encore trop élevé pour beaucoup.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_050',
  'Thème du débat : « Apprendre une langue en ligne »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Grâce à Internet, il est tout à fait possible d’apprendre une langue en ligne, et les résultats sont souvent très bons ! Contrairement aux cours en présentiel, on peut suivre les leçons quand on le souhaite, puisqu’elles sont disponibles 24h/24. Cela aide à mieux gérer son emploi du temps. Et il n’y a plus besoin de parcourir de longues distances pour aller dans une école. On peut apprendre depuis chez soi, depuis son lieu de travail ou même dans un café. Cela permet aussi d’économiser de l’argent.

Document B :
On pourrait croire que l’apprentissage d’une langue en ligne est facile, mais ce n’est pas accessible à tous. Il faut d’abord avoir un bon accès à Internet et un équipement numérique suffisant. Ensuite, il est nécessaire d’être autonome, car étudier seul à la maison demande beaucoup de motivation, surtout sans l’aide d’un enseignant ou d’autres apprenants. Dans ces cas-là, on peut rapidement se décourager et abandonner.',
  NULL,
  true
);

INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
(
  'expression_ecrite',
  3,
  'EE_T3_051',
  'Thème du débat : « Animaux de compagnie au bureau : pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Apporter son animal au travail est une pratique qui se développe. Son intérêt ? Réduire le stress des employés. Les chiens ou les chats changent l’atmosphère de l’entreprise et diminuent les conflits entre collègues. C’est important, car chaque année, l’État français consacre 2 à 3 milliards d’euros pour soigner le stress au travail. Une enquête montre également qu’un quart des salariés pensent que les animaux améliorent leur motivation. 
 — D’après challenges.fr

Document B :
« Dans l’entreprise où je travaille, il est permis d’amener son animal, qu’il s’agisse d’un chien ou d’un chat. Pour ma part, cela me dérange. Je ne suis pas très confortable avec les animaux, qui peuvent agir de façon inattendue. Cela peut aussi poser des problèmes de santé : qu’en est-il des employés allergiques aux chats ? Devraient-ils rester isolés dans leur bureau ? Et puis, cela constitue une source de distraction. Un chien ou un chat n’améliorera pas notre productivité ! » — Alba, 32 ans',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_052',
  'Thème du débat : « La publicité alimentaire ciblant les enfants. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Beaucoup trouvent la publicité agaçante, mais à mon avis, elle est très utile pour les entreprises. Elle sert à présenter un produit ou un service. Parfois, elle est même drôle ! J’aime bien l’écouter quand je conduis. Elle m’aide également à découvrir les nouveautés et les offres spéciales. Pour moi, comparer les articles grâce à la publicité permet de faire de bonnes économies. Enfin, les jeux gratuits sur téléphone dépendent des publicités ; sans elles, ils seraient payants. 
 — Lucien, 28 ans

Document B :
Nous sommes entourés de publicité tous les jours : journaux, radios, télévisions, smartphones, Internet… Par exemple, les émissions télévisées sont souvent coupées par des pubs, ce qui peut être irritant. Recevoir des kilos de publicité chaque année dans la boîte aux lettres n’est pas non plus bon pour l’environnement ! Selon moi, il serait utile de créer une loi pour limiter les publicités à la télévision et par courrier. Des publicités plus discrètes seraient mieux reçues.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_053',
  'Thème du débat : « Objets Connectés »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les objets intelligents rendent notre quotidien plus pratique. Ce sont des appareils qui peuvent être contrôlés à distance par un téléphone ou Internet, comme le chauffage ou les systèmes de sécurité de la maison. Par ailleurs, des objets tels que les montres ou bracelets connectés suivent nos activités et nous motivent à faire plus d’exercice, en mesurant par exemple nos pas. Leur utilité est particulièrement notable dans le domaine de la santé. Certains objets agissent comme un assistant santé, nous rappelant les rendez-vous médicaux ou la prise de nos médicaments.

Document B :
On estime qu’il y aurait 50 milliards d’objets intelligents dans le monde, tels que des alarmes, des téléviseurs, des caméras de surveillance, des volets ou des détecteurs de fumée, entre autres. Avec cette expansion, la question de la sécurité devient cruciale. En effet, un hacker pourrait prendre le contrôle de ces appareils en quelques minutes. Par exemple, un cambrioleur pourrait, grâce aux caméras de surveillance connectées, vérifier si les habitants sont absents avant de commettre un cambriolage. Il est même possible d’accéder au système connecté d’une voiture et de la contrôler à distance.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_054',
  'Thème du débat : « L''accès gratuit aux musées »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La gratuité fait partie des principes fondamentaux des musées et symbolise le partage culturel. Tous les acteurs du monde culturel s’accordent à dire qu’il faut faciliter l’accès à la culture pour tous. À la différence des théâtres ou des opéras, les musées ont une tradition de gratuité : une fois par mois, l’entrée des musées nationaux est gratuite pour tous. Cette mesure a pour but de faire venir de nouveaux visiteurs, car le musée reste avant tout un lieu d’éducation pour le plus grand nombre.

Document B :
Rendre les musées totalement gratuits est une fausse bonne idée, car cela fait croire que la culture ne nécessite aucun financement. Pourtant, les musées doivent recevoir des fonds pour maintenir et développer leurs collections. Une solution plus adaptée est de proposer des entrées à tarif réduit pour des publics ciblés. Pour que cela fonctionne, il est important d’accompagner ces visiteurs avec des visites ou activités adaptées, comme pour les jeunes ou les personnes à mobilité réduite. Ouvrir les portes n’est pas suffisant : il faut créer une interaction entre le musée et ses visiteurs.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_055',
  'Thème du débat : « Art urbain ou vandalisme ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Dans les grandes villes, on voit de plus en plus de peintures et de dessins sur les façades des bâtiments publics et privés. Cet art de rue permet à la culture d’être présente dans l’espace public. Pour certains maires, il est essentiel de donner aux artistes des espaces où ils peuvent travailler légalement. Ces graffitis attirent aussi les touristes, qui peuvent participer à des circuits thématiques et explorer des lieux peu connus.

Document B :
Chaque année, certaines villes investissent des sommes importantes pour lutter contre les graffitis. Les dessins sur les murs, les bancs ou dans les stations sont difficiles à enlever et demandent parfois l’aide de professionnels. Pour certains habitants, ces peintures nuisent à l’image de leur quartier et dérangent les propriétaires, obligés de les nettoyer eux-mêmes. Malgré les règlements et les amendes, les graffitis persistent dans les villes.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_056',
  'Thème du débat : « La restauration rapide »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Catherine «Je suis complètement contre les chaînes de fast-food, car on ignore souvent quels ingrédients sont utilisés dans leurs plats. Selon moi, la qualité de la nourriture y est faible. Manger ce type d’aliments peut provoquer des maladies, comme le montre le documentaire américain « Supersize Me ». Certes, les hamburgers, sandwichs et frites sont très pratiques et bon marché. Mais, à mon avis, il est important de faire d’autres choix pour rester en bonne santé.»

Document B :
Bernard «Je soutiens la restauration rapide. Je travaille pour une chaîne célèbre, je pense qu’on peut y trouver des repas équilibrés. Les menus comprennent des légumes, des salades, du pain et de la viande. Chaque client est responsable de ce qu’il mange : choisir plusieurs sandwiches et trop de sauce n’est pas un repas sain. Ces restaurants sont aussi très propres et faciles d’accès pour les familles ou les groupes d’amis.»',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_057',
  'Thème du débat : « Maisons de retraite ou maintien à domicile ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les maisons de retraite représentent une solution adaptée pour les personnes âgées. Elles y bénéficient de soins appropriés et d’un encadrement professionnel. En plus, elles ont la possibilité de participer à diverses activités qui leur permettent de garder une vie sociale et d’éviter la solitude. Dans certains cas, c’est mieux que de rester seules chez elles.

Document B :
Les maisons de retraite peuvent priver les personnes âgées de la présence de leur famille et donner l’impression d’être abandonné. De plus, les conditions de vie ne sont pas toujours satisfaisantes et certains établissements manquent parfois de personnel compétent. Selon moi, l’aide à domicile est une meilleure solution pour vieillir auprès de ses proches.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_058',
  'Thème du débat : « Faut-il faire ses courses chez les producteurs locaux ou au supermarché ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Arthur, installé à la campagne, préfère acheter ses produits alimentaires directement à la ferme pour leur qualité, même si cela lui coûte un peu plus cher.

Document B :
Alice, citadine, préfère faire ses courses au supermarché en raison de la large gamme de produits et des prix accessibles.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_059',
  'Thème du débat : « Restauration rapide »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les fast-foods se caractérisent par la variété de plats sains qu’ils proposent, en respectant scrupuleusement les normes d’hygiène. En donnant aux clients la possibilité de créer leur propre menu, ils les responsabilisent dans leurs choix alimentaires tout en tenant compte de leurs goûts.

Document B :
Les experts expliquent que consommer régulièrement des repas dans des fast-foods peut nuire à la santé. Les plats proposés sont souvent les mêmes : hamburgers, frites et boissons sucrées, riches en calories, bien trop pour un seul repas. De plus, la plupart des produits sont emballés dans du plastique, ce qui génère beaucoup de déchets et nuit à l’environnement.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_060',
  'Thème du débat : « Sieste au travail »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Selon le site siestepourtous.com, une courte sieste au travail pourrait augmenter la productivité et la créativité des employés de 35 %, ce qui représente un vrai bénéfice pour le salarié comme pour l’entreprise. De plus, la sieste améliorerait la mémoire et la concentration. Un employé reposé n’aurait plus sommeil et serait plus disponible pour ses tâches. Enfin, faire une sieste au bureau aiderait à réduire le stress et les risques cardiaques.

Document B :
Même si les bienfaits de la micro-sieste ont été prouvés scientifiquement, certaines personnes restent sceptiques et voient des inconvénients à la mettre en place au travail. La sieste au bureau pose des difficultés pratiques. En effet, toutes les entreprises ne peuvent pas disposer de lits ou de salles spécifiques pour permettre aux employés de se reposer. Lorsqu’une entreprise souhaite instaurer un temps de repos, elle doit respecter certaines règles : fournir un espace et du matériel adaptés pour éviter tout harcèlement, garantir l’égalité entre tous les salariés et établir une charte encadrant cette pratique.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_061',
  'Thème du débat : « Productivité et confort au travail »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
(Louise, responsable) « Dans votre entreprise, nous avons mis en place des bureaux réglables en hauteur pour que les employés puissent travailler dans la position qui leur convient. Ils sont satisfaits et affirment être plus performants et efficaces, par exemple lors des négociations au téléphone. De plus, le climat social s’est amélioré et les échanges verbaux entre collègues sont plus fréquents. »

Document B :
(Dubois, ingénieur) « Aujourd’hui, les entreprises cherchent toujours à augmenter la productivité et l’efficacité, et les employés passent plus de temps au travail. Elles essaient de trouver des méthodes pour inciter leurs salariés à en faire plus tout en prenant soin de leur santé. Pour ma part, ce qui compte, c’est de réaliser mon travail pendant mes heures normales, sans devoir faire des heures supplémentaires. »',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_062',
  'Thème du débat : « Jeux vidéo : un loisir utile ou dangereux ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Des recherches ont montré que certaines parties du cerveau des adultes peuvent se développer grâce aux jeux vidéo. Ainsi, jouer peut-être bénéfique, car cela aide, par exemple, à renforcer l’analyse, la prise de décision et la rapidité de réaction. C’est une bonne nouvelle, puisque 83 % des joueurs sont des adultes. Toutefois, il faut rester vigilant, car certains jeux vidéo n’apportent pas ces effets positifs sur le cerveau.

Document B :
Durant trois ans, des chercheurs ont observé des enfants de 8 à 17 ans pour étudier les effets des jeux vidéo. Les conclusions indiquent que les enfants qui y jouent beaucoup deviennent plus violents, plus tendus et plus stressés que les autres. Ils réussissent aussi moins bien à l’école. C’est pourquoi il est conseillé aux parents de faire attention et de contrôler le temps passé devant les jeux vidéo.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_063',
  'Thème du débat : « L''art urbain »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Dans les grandes villes, il y a de plus en plus de peintures et de dessins sur les murs des maisons, des écoles et même des églises. Cet art urbain permet à la culture d''avoir une place dans l''espace public. Selon certains maires, il est important que les villes aident les artistes en leur proposant des espaces où ils sont autorisés à peindre. De plus, ces graffitis attirent les touristes qui peuvent participer à des visites thématiques sur cet art. Ils peuvent ainsi découvrir des lieux moins connues.

Document B :
Certaines villes dépensent chaque année une somme d''argent importante pour lutter contre les peintures de rue. Ces dessins sur les murs, sur les bancs ou dans les stations de métro sont difficiles à enlever. Il est parfois nécessaire de faire appel à des équipes de nettoyage spécialisées. Pour certains habitants, ces peintures donnent une mauvaise image de leurs quartiers. Elles provoquent aussi la colère des propriétaires des murs qui sont parfois obligés de les nettoyer eux-mêmes. Cependant, malgré les interdictions des mairies et les amendes, les graffitis continuent d''apparaître sur les murs des villes.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_064',
  'Thème du débat : « Parents exigeants ou permissifs. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
J’ai 19 ans et je vis toujours avec mes parents. Même si je suis maintenant majeure et capable de me gérer seule, ils restent très exigeants avec moi. Avant mes 18 ans, je devais être à la maison avant 20 heures et je n’avais pas le droit de passer la nuit chez mes copines. Aujourd’hui, j’ai un peu plus de liberté, mais ma mère reste très inquiète. Elle m’appelle souvent pour savoir où je suis et ne dort pas tant que je ne suis pas rentrée. Mes parents me laissent un peu de liberté, mais j’ai l’impression d’être plus surveillée que les autres jeunes.

Document B :
Certains parents choisissent de ne pas être trop sévères et laissent beaucoup de liberté à leurs enfants. Ils ont peur que trop de règles les rendent tristes ou qu’ils manquent de confiance en eux. Ces parents acceptent donc presque tout ce que leurs enfants demandent. Cela ne cause pas vraiment de problèmes quand ils sont petits, mais plus tard, devenus adultes, ils auront du mal à respecter les règles et à vivre en société.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_065',
  'Thème du débat : « Petits commerces vs grandes surfaces : où faire ses courses ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Aller au supermarché pour faire ses courses est très pratique. On peut y trouver tout : fruits, légumes, viandes, fromages, et d’autres produits. Il y a beaucoup de choix et les prix sont souvent meilleurs que dans les petites boutiques. De plus, les supermarchés font gagner du temps et proposent de grands parkings faciles à utiliser. Acheter en grande quantité aide aussi à économiser.

Document B :
Association pour soutenir les petits commerces. 
 Le projet « Un mois sans supermarché » a pour objectif de réduire l’impact des grandes surfaces et soutenir les commerçants locaux. Le concept est simple : pendant un mois, éviter les supermarchés et favoriser les magasins du quartier. Cette action souligne l’importance de l’achat local, car les produits sont souvent plus frais et cela renforce les liens entre voisins.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_066',
  'Thème du débat : « La publicité : utile ou gênante ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
(Elena, 28 ans) 
 Beaucoup de gens trouvent la publicité agaçante, mais pour moi, elle est essentielle au fonctionnement du commerce et des entreprises. Grâce à elle, on découvre de nouveaux produits et services. En plus, certaines publicités sont amusantes ! J’aime les écouter quand je conduis, car elles me tiennent au courant des nouveautés et des offres spéciales. J’aime aussi comparer les produits, ce qui me permet d’économiser de l’argent. Enfin, il faut savoir que sans la publicité, de nombreuses applications ou jeux gratuits sur téléphone deviendraient payants.

Document B :
(Alicia, 35 ans) 
 La publicité fait partie de notre vie quotidienne : dans les journaux, à la radio, à la télévision, sur le téléphone et sur Internet. Par exemple, certaines émissions télévisées sont interrompues par des publicités, ce qui est vraiment agaçant. En plus, recevoir chaque année beaucoup de papiers publicitaires dans la boîte aux lettres, ce n’est pas bon pour l’environnement. À mon avis, il faudrait une loi pour limiter la publicité à la télé et par courrier. Si elle était plus discrète, les gens l’apprécieraient davantage.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_067',
  'Thème du débat : « Cours de langue en ligne »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Apprendre une langue sur Internet, c’est tout à fait possible et les résultats sont souvent très bons ! Contrairement aux cours en présentiel, on peut étudier à n’importe quel moment : les leçons sont accessibles en continu. Cela aide à mieux gérer son emploi du temps. De plus, il n’est plus nécessaire de se déplacer jusqu’à une école de langues. On peut apprendre tranquillement depuis chez soi, depuis son lieu de travail ou même dans un café du quartier. C’est aussi une façon de dépenser moins d’argent.

Document B :
Apprendre une langue sur Internet paraît facile, mais ce n’est pas à la portée de tout le monde. En effet, il faut avoir une bonne connexion et un appareil adapté comme un ordinateur, un téléphone ou une tablette. De plus, il faut être très autonome pour apprendre seul : ce n’est pas simple de travailler chez soi et de rester motivé sans le soutien d’un professeur ou de camarades. Dans ces conditions, on peut vite se décourager et abandonner.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_068',
  'Thème du débat : « Maisons de retraite : pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Je vis dans un pays où il existe très peu de maisons de retraite. Chez nous, quand une personne âgée ne peut plus vivre seule, elle reste avec les plus jeunes de la famille. En général, cela ne crée pas de gros problèmes. Pour nous, il est surprenant de laisser nos parents ou grands-parents à des inconnus pour s’occuper d’eux.

Document B :
Beaucoup de personnes critiquent les maisons de retraite, mais c’est pourtant une bonne option pour les personnes âgées ! D’abord, cela permet d’éviter la solitude, car elles sont entourées de gens de leur âge. Ensuite, ces établissements offrent des soins et une aide médicale adaptés. Enfin, c’est une solution pratique et rassurante pour les enfants et les petits-enfants. Malheureusement, ce type d’hébergement reste trop coûteux pour certains.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_069',
  'Thème du débat : « Le travail : un bénéfice ou un frein ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Le travail tient une place essentielle dans nos vies. Dès notre enfance, on nous interroge : « Que veux-tu devenir ? ». Travailler devrait être source de réussite et de satisfaction, mais pour beaucoup, il apporte surtout stress et contraintes. Aujourd’hui, certains considèrent qu’on néglige la vie familiale et sociale. Ils estiment qu’il est nécessaire de réévaluer le rôle du travail et de réduire sa durée pour améliorer la qualité de vie.

Document B :
Certaines personnes ont décidé de quitter leur emploi pour adopter un autre style de vie. Pourtant, travailler reste important aujourd’hui. La question « Que fais-tu dans la vie ? » revient souvent lors des rencontres, montrant que le travail fait partie de notre identité. Selon Jean-Daniel Remond, l’entreprise joue un rôle essentiel : les relations, les réseaux, les amitiés, le sentiment d’utilité et même les difficultés contribuent à construire sa personnalité.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_070',
  'Thème du débat : « Colocation : bénéfices et inconvénients »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La colocation offre de nombreux avantages. Partager un appartement avec d’autres permet de diminuer le loyer, les charges et les dépenses communes. Elle favorise également les rencontres et les échanges culturels. Habiter avec d’autres personnes permet de rencontrer des individus différents, de nouer des amitiés et de vivre des expériences intéressantes.

Document B :
La colocation présente aussi des inconvénients. Les différences de personnalité et de mode de vie peuvent provoquer des tensions. La répartition des tâches ménagères et des responsabilités peut engendrer des conflits. De plus, la colocation réduit parfois l’intimité et l’espace personnel. Pour que la cohabitation se passe bien, il est important d’avoir une communication claire et respectueuse et de fixer des règles partagées.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_071',
  'Thème du débat : « Ville ou campagne : choisir son cadre de vie »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Depuis que j’ai déménagé à la campagne, ma vie a complètement changé. Les chants des oiseaux et mon jardin ont remplacé les pharmacies et cinémas de la ville. Je voulais fuir le bruit, la pollution et la foule pour profiter du calme et des espaces verts. Ici, je savoure la tranquillité et de grands espaces sans voisins proches. (Marie, 42 ans)

Document B :
La vie rurale n’est pas adaptée à tous. Les commerces, loisirs et services essentiels comme les écoles ou hôpitaux peuvent se trouver à plusieurs kilomètres. Il est souvent nécessaire d’utiliser la voiture, et Internet n’est pas toujours fiable. La ville, en revanche, facilite les déplacements et procure un confort quotidien supérieur. (Claire, 35 ans)',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_072',
  'Thème du débat : « Privilégier la ferme ou le supermarché pour ses courses ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Je réalise mes achats alimentaires à moins de dix kilomètres de chez moi. Habitant à la campagne, je peux acheter directement à la ferme et discuter avec les producteurs. Le prix est parfois plus élevé, mais les produits sont de meilleure qualité et je connais leur origine. Pour moi, il est essentiel de faire confiance aux producteurs locaux et de consommer des produits régionaux.

Document B :
Pour mes courses, je me rends toujours au supermarché, c’est ma préférence. Habitant en centre-ville, c’est plus pratique, surtout avec les enfants. Je peux trouver tous les produits au même endroit et profiter des promotions. Pour moi, l’important est de gagner du temps, de réduire mes dépenses et de faire mes courses près de chez moi. Je préfère garder de l’argent pour des loisirs comme aller au cinéma ou sortir au restaurant.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_073',
  'Thème du débat : « Sieste au travail »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Faire une sieste au travail présente de nombreux bénéfices pour les salariés et les entreprises. Permettre aux employés de se reposer quelques minutes peut accroître leur productivité et améliorer leur santé et leur bien-être. Les courtes siestes renforcent la concentration, diminuent le stress et améliorent l’humeur. Elles peuvent aussi réduire les coûts liés à la fatigue et aux accidents. Les entreprises devraient donc envisager d’intégrer cette pratique pour leur personnel.

Document B :
Même si la sieste au travail présente de nombreux bénéfices, il n’est pas facile pour toutes les entreprises d’aménager des espaces ou des lits pour cela. Les contraintes financières, logistiques ou les règles strictes peuvent empêcher les salariés de se reposer. De plus, certains employés peuvent se sentir mal à l’aise. Il est donc important que les entreprises évaluent avantages et limites et trouvent des solutions pour favoriser le repos.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_074',
  'Thème du débat : « Jeunes et emploi : faut-il privilégier diplôme ou expérience ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Beaucoup de jeunes sortant de l’université se retrouvent sans emploi. La valeur des diplômes sur le marché du travail pose des questions. Souvent, les recruteurs leur reprochent d’avoir trop étudié et trop peu d’expérience, ou considèrent leur jeunesse comme un frein. Plus de 60 % des diplômés restent sans travail un an après leurs études. Il paraît donc urgent de mieux reconnaître les diplômes et de faciliter l’insertion professionnelle.

Document B :
On parle souvent de dirigeants célèbres qui ont réussi sans suivre de cursus universitaire. Ces exemples peuvent laisser penser qu’il suffit d’être talentueux pour diriger une entreprise. Certains chefs d’entreprise considèrent même que l’université peut freiner la créativité. Selon eux, elle pousse les étudiants à suivre des parcours standards et limite l’innovation. Pour les futurs entrepreneurs, rien ne remplacerait l’expérience pratique et l’autoformation, sans dépendre d’une institution académique.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_075',
  'Thème du débat : « Vivre en ville ou à la campagne »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Selon moi, vivre en ville offre beaucoup d’occasions de se divertir : aller au cinéma, manger dans un restaurant, faire les magasins… Tout est accessible sans devoir parcourir de longues distances ni chercher un taxi pour un trajet. On trouve facilement tout ce dont on a besoin. De plus, les amateurs de culture y trouvent aussi leur bonheur : musées, théâtres, opéras… tout est présent !

Document B :
Récemment, j’ai choisi de quitter la vie urbaine pour m’installer à la campagne, car je ressentais le besoin de me rapprocher de la nature et de profiter de la tranquillité. Aujourd’hui, au lieu de sortir chaque jour dans un café ou un restaurant, je préfère inviter mes amis sur ma terrasse ou organiser parfois un barbecue dans mon jardin. Une autre raison qui m’a poussé à ce choix, c’est le prix des logements : en campagne, les maisons sont beaucoup plus abordables. Avec mon budget actuel, je profite d’une grande maison avec terrasse et jardin, alors qu’en ville je n’avais qu’un petit appartement au cinquième étage.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_076',
  'Thème du débat : « Publicité et enfants : est-ce bénéfique ou nocif ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
D’après une enquête, les enfants sont en permanence confrontés à de nombreuses publicités diffusées à la télévision, dans les journaux ou sur Internet, souvent dans des espaces où ils sont vulnérables. Celles-ci ciblent principalement les jouets, les jeux vidéo et les aliments peu sains, ce qui influence leurs décisions et leurs demandes familiales.

Document B :
Un travail de recherche parue dans une revue scientifique montre que les enfants comprennent difficilement les messages publicitaires, même s’ils savent généralement que leur but est de persuader. Pourtant, d’autres facteurs comme l’éducation reçue des parents, la société et la culture ont un poids plus fort sur leurs choix de consommation que la publicité.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_077',
  'Thème du débat : « Réduction du temps de travail »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Réduire le temps de travail aide les employés à trouver un meilleur équilibre entre leur vie professionnelle et personnelle. En ayant plus de temps libre, ils peuvent consacrer davantage de moments à leur famille, à leurs loisirs et à leur santé. Cela améliore leur satisfaction au travail, diminue le stress et contribue à augmenter leur efficacité globale.

Document B :
Réduire les heures de travail peut aider les entreprises en réduisant l''absentéisme et en augmentant la fidélisation des employés. En offrant des horaires plus flexibles, les employés sont généralement plus motivés et impliqués. Cependant, cela nécessite une organisation efficace et une adaptation des processus pour maintenir la productivité et répondre aux besoins de l''entreprise.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_078',
  'Thème du débat : « Impact des vêtements de marque sur les enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les vêtements de marque jouent un rôle essentiel pour les enfants et les adolescents en leur permettant de s''exprimer et de se sentir intégrés dans un groupe social. Cette attraction pour les marques est particulièrement forte chez les adolescents qui cherchent à affirmer leur personnalité. De même, les enfants apprécient porter des vêtements de marque ornés d''images de leurs dessins animés préférés ou de logos qu''ils affectionnent.

Document B :
Les enfants grandissent rapidement, ce qui rend leurs vêtements trop petits après peu de temps. De plus, jouer à l''extérieur avec leurs amis dans l''herbe ou sur les aires de jeux fait que leurs vêtements s''usent vite et se salissent rapidement, souvent avec des trous.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_079',
  'Thème du débat : « L''accès gratuit aux musées : avantage ou inconvénient ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
L’accès gratuit aux musées peut engendrer une affluence excessive, altérant ainsi la qualité de la visite. De plus, cela risque de diminuer leurs revenus, compromettant l’entretien des lieux et la conservation des œuvres. Une tarification réduite serait une alternative équilibrée pour favoriser l’accès à la culture tout en assurant le bon fonctionnement des musées.

Document B :
Rendre les musées gratuits est une excellente initiative, car cela permet à tous d’accéder à la culture, quel que soit leur revenu. J’ai eu l’opportunité de visiter plusieurs musées sans frais, ce qui m’a permis d’enrichir mes connaissances sans me préoccuper du coût. À mon avis, la gratuité des musées joue un rôle clé dans l’éducation du public et la diffusion du patrimoine culturel.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_080',
  'Thème du débat : « L’art urbain : Pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
L’art éveille la curiosité des citadins et transforme l’espace urbain en un lieu d’échange entre artistes et passants. Peintures et spectacles de rue créent une atmosphère immersive, rendant l’art accessible à tous. Aujourd’hui, la ville ne se limite plus à un simple espace de vie ; elle évolue, s’adapte à sa diversité, intègre des espaces verts et s’embellit grâce au street art, favorisant ainsi une meilleure qualité de vie tout en respectant l’environnement.

Document B :
À plus grande échelle, les graffitis divisent l’opinion. Perçus par certains comme une forme de vandalisme défigurant l’espace public, ils sont associés à une rupture sociale et à une pollution visuelle. Ce débat opposant artistes, législateurs et citoyens reste vif.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_081',
  'Thème du débat : « La restauration rapide »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les restaurants de restauration rapide offrent une gamme variée de plats équilibrés tout en respectant les normes d’hygiène. Le client, ayant la liberté de composer son propre menu, assume ainsi la responsabilité de ses choix alimentaires.

Document B :
La consommation fréquente de restauration rapide peut avoir des effets néfastes sur la santé, contribuant à l''apparition de problèmes graves et irréversibles tels que l''obésité et d''autres maladies associées.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_082',
  'Thème du débat : « La colocation : entre avantages et inconvénients »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vivre en colocation peut être une belle expérience humaine. Que ce soit avec un ami ou une personne que l’on apprend à connaître, cela permet de créer de nouveaux liens, de partager des moments agréables en rentrant le soir, comme discuter autour d’un repas ou regarder un film ensemble. C’est aussi un bon moyen de se répartir les tâches ménagères et de bénéficier des compétences de chacun, que ce soit en cuisine ou en bricolage.

Document B :
Vivre en colocation est une expérience bien différente de la vie en famille. Chacun a son propre rythme, sa personnalité et ses priorités, ce qui peut parfois compliquer la cohabitation. Si le courant ne passe pas avec le colocataire, cela peut vite devenir difficile à vivre. Les conflits surviennent souvent à cause du non-respect des tâches partagées ou du manque d’intimité. Le bruit peut aussi poser problème, comme un colocataire qui joue à des jeux vidéo tard dans la nuit.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_083',
  'Thème du débat : « Photo sur le CV : pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
De nos jours, certains candidats ajoutent une photo sur leur CV, d’autres non. Des experts recommandent de l’interdire pour éviter toute forme de discrimination. Une étude montre que les recruteurs s’intéressent d’abord à l’expérience (32 %) et aux diplômes (15 %), tandis que seulement 2 % commencent par regarder la photo. Une statistique étonnante, vu l’importance souvent accordée à l’apparence.

Document B :
La présence d’une photo sur le CV fait débat chez les employeurs. Certains estiment qu’elle permet de mieux visualiser le candidat et de s’en souvenir plus facilement parmi de nombreux dossiers. D’autres pensent que cela dépend du poste : dans les métiers d’accueil, par exemple, une photo peut être utile, à condition qu’elle soit professionnelle et transmette une image positive.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_084',
  'Thème du débat : « L’aide aux personnes en difficulté »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Marie, 58 ans, consacre chaque hiver un peu de son temps et de son argent pour aider les personnes sans abri. Elle estime que la solidarité est essentielle et que chacun peut contribuer, même par de petits gestes.

Document B :
Paul, 63 ans, pense que donner de l’argent ne suffit pas pour aider réellement les personnes en difficulté. Il préfère s’investir dans une association locale qui aide les sans-abris à trouver un emploi et un logement, leur offrant ainsi une solution durable.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_085',
  'Thème du débat : « Les Zoos : Outils de Conservation ou Prisons pour Animaux ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Selon le texte, les animaux sauvages ne doivent pas vivre dans les zoos, car ce n’est pas leur milieu naturel. Les zoos ressemblent à des prisons. Il y a même des ours polaires dans des endroits trop chauds. Les animaux doivent rester libres, dans la nature.

Document B :
Le texte dit que les zoos ont beaucoup d’avantages. Ils aident à protéger les animaux en voie de disparition. Les animaux y sont bien soignés. Grâce aux zoos, il y a plus de naissances et cela peut sauver certaines espèces.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_086',
  'Thème du débat : « Les Jeux Vidéo : Bienfaits Cognitifs ou Risque de Dépendance ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Contrairement à l''idée reçue que les jeux vidéo rendent moins intelligents, de nombreuses études montrent le contraire. Par exemple, les jeux de course améliorent le sens de l''orientation, la mémoire et la précision des mouvements. D''autres recherches indiquent des bénéfices pour la rapidité et la concentration des joueurs. De plus, certains jeux d''entraînement sont spécifiquement conçus pour renforcer la mémoire et la vivacité d''esprit chez les personnes âgées. En somme, les jeux vidéo peuvent avoir des effets positifs sur les capacités cognitives.

Document B :
Les jeux vidéo, qu''ils soient joués sur console ou sur ordinateur, à domicile ou en salle, seul, entre amis ou en ligne, peuvent entraîner une dépendance chez certaines personnes. L''addiction survient lorsque le jeu devient la principale (ou seule) source d''intérêt, au détriment d''autres activités comme les relations sociales, le travail, les études ou les loisirs. Ce phénomène est particulièrement préoccupant durant l''adolescence, une période où l''impact des jeux vidéo peut nuire aux performances scolaires.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_087',
  'Thème du débat : « Les Bienfaits Cognitifs des Jeux Vidéo »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Jusqu’à l’adolescence, les enfants jouent de manière régulière aux jeux vidéo, ce qui, à force, peut entraîner des effets négatifs sur leur comportement. Une étude récente, réalisée auprès de jeunes de 9 à 18 ans, indique que l’exposition aux jeux vidéo violents accroît significativement les tendances agressives. Diego Gentil affirme même que ce phénomène est inévitable, quel que soit le degré d’implication des parents.

Document B :
On évoque souvent les effets néfastes des jeux vidéo, mais il ne faut pas oublier qu’ils présentent aussi certains bénéfices pour le cerveau et la santé en général. Par exemple, ils peuvent renforcer différentes fonctions cognitives telles que la concentration, la créativité ou encore les capacités d’analyse. Cela semble logique, puisqu’un joueur est constamment amené à résoudre des problèmes ou à prendre des décisions.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_088',
  'Thème du débat : « Le Travail : Favorable Ou Défavorable ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Le travail occupe une grande place dans notre vie. Dès l’enfance, on nous demande souvent ce que l’on veut faire plus tard. Il devrait apporter satisfaction et succès, mais trop souvent il est source de fatigue et de contraintes. Beaucoup pensent qu’on ne passe pas assez de temps avec nos proches. Il est temps de repenser la place du travail dans notre société. Certains estiment que travailler moins nous offrirait plus de temps pour profiter de la vie.

Document B :
Certaines personnes ont pris la décision de ne plus travailler pour changer leur mode de vie. Cependant, aujourd’hui, le travail est un moyen de se définir. Lors de nouvelles rencontres, on nous pose souvent la question : « Que fais-tu dans la vie ? ». Cela montre que notre emploi est lié à notre identité. Jean-Daniel Remond, spécialiste du sujet, affirme que la vie en entreprise est essentielle. Les interactions quotidiennes, les réseaux sociaux, les amitiés et même les défis sont des éléments qui contribuent à façonner notre personnalité et notre identité.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_089',
  'Thème du débat : « Les produits faits maison : un choix judicieux ou un risque ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La fabrication artisanale de produits biologiques à domicile permet un contrôle absolu sur la composition, garantissant des alternatives à la fois plus saines et personnalisées. Elle participe aussi à la réduction des déchets plastiques, notamment grâce à l’utilisation d’emballages réutilisables. Ce choix écologique, en plus d’être économique à long terme, encourage l’acquisition de compétences créatives et soutient un mode de vie durable.

Document B :
Malgré ses avantages, la fabrication de produits bio à domicile présente certains risques. Une mauvaise formulation peut nuire à l’efficacité du produit ou provoquer des irritations. Par ailleurs, le temps et l’effort requis pour trouver les bons ingrédients représentent un véritable défi. De plus, en l’absence de contrôle strict, les produits peuvent être instables ou contaminés. Le coût initial élevé pour se procurer des ingrédients fiables constitue également un frein pour de nombreuses personnes.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_090',
  'Thème du débat : « La livraison de repas au bureau : pratique ou problématique ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Céline, 25 ans : La livraison de repas représente un gain de temps appréciable, notamment pour les personnes actives. Par exemple, il est possible de se faire livrer directement sur son lieu de travail, ce qui évite de se déplacer pendant la pause déjeuner. Cela permet ainsi d’optimiser son emploi du temps et de rentrer plus tôt chez soi. Ce service offre également une grande variété de choix : chacun peut commander ce qu’il souhaite, même dans des restaurants différents, ce qui évite les désaccords. Un autre avantage est sa disponibilité permanente, puisque certains établissements restent ouverts 24 heures sur 24.

Document B :
Ahmed, 40 ans : La livraison de repas séduit de plus en plus de consommateurs, en particulier ceux qui manquent de temps ou ne souhaitent pas cuisiner. Cependant, ce service a un impact environnemental non négligeable. Les livraisons sont fréquemment effectuées en scooter ou en voiture, des moyens de transport polluants. Ce mode de consommation peut également nuire à la vie sociale. En effet, recevoir ses repas au bureau ou à domicile pousse souvent à rester à l’intérieur et à limiter ses interactions. Pourtant, sortir, prendre l’air et rencontrer d’autres personnes reste essentiel pour le bien-être.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_091',
  'Thème du débat : « Caméras de surveillance : utile ou excessive ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
On voit de plus en plus de caméras de surveillance dans les villes aujourd’hui. Beaucoup de Français apprécient leur présence, car cela les rassure. D’après un sondage, 75 % des personnes soutiennent le développement de la vidéosurveillance. 
 Ils sont d’accord pour être filmés dans les lieux publics, mais ils refusent d’être surveillés au travail. En France, les caméras sont d’ailleurs rares dans les entreprises.

Document B :
Certaines études montrent que la vidéosurveillance est coûteuse et peu efficace. D’abord, les caméras sont faciles à repérer, ce qui limite leur utilité pour prévenir les vols, la drogue ou la violence dans les villes. Ensuite, il faut beaucoup de personnel pour analyser les images. Une étude en Allemagne indique que sept personnes sont nécessaires pour surveiller une seule caméra.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_092',
  'Thème du débat : « Impact des Jeux Vidéo sur les Enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Des recherches ont démontré que certaines régions du cerveau adulte peuvent se développer grâce aux jeux vidéo. Ces derniers peuvent, par exemple, améliorer les capacités d’analyse, de prise de décision et la rapidité de réaction. Cette information est intéressante, d’autant plus que 83 % des joueurs sont des adultes. Toutefois, il est important de rester vigilant, car tous les jeux vidéo ne contribuent pas à ces améliorations cérébrales.

Document B :
Une étude menée sur une période de trois ans auprès d''enfants de 8 à 17 ans a révélé que ceux qui jouent fréquemment aux jeux vidéo tendent à être plus violents, nerveux et stressés que ceux qui y jouent moins ou pas du tout. De plus, ces enfants obtiennent généralement de moins bons résultats scolaires. Il est donc recommandé aux parents de surveiller de près l''utilisation des jeux vidéo par leurs enfants et de limiter leur durée de jeu.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_093',
  'Thème du débat : « Uniforme Scolaire »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Le port de l’uniforme scolaire peut limiter l’expression personnelle des élèves, notamment ceux qui souhaitent affirmer leur identité à travers leur style vestimentaire. Certains estiment qu’il est important de laisser aux jeunes la liberté de choisir leurs vêtements afin de développer leur personnalité et leur créativité. Pour ces personnes, l’uniforme donne le sentiment d’imposer une conformité qui peut frustrer ceux qui aiment se distinguer par la mode ou les accessoires.

Document B :
Le port de l’uniforme scolaire favorise un sentiment d’appartenance à l’établissement et renforce le sens de la communauté parmi les élèves. Il peut également engendrer un sentiment de fierté d’appartenir à une institution. De plus, l’uniforme aide à réduire les discriminations liées au style vestimentaire ou à la classe sociale. Il offre également un avantage économique pour les familles, car il permet d’éviter les dépenses élevées pour des vêtements de marque, rendant l’accès à l’éducation plus égalitaire.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_094',
  'Thème du débat : « La question de la consommation de viande »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Daniel : 
 Je suis opposé à la consommation de viande pour plusieurs raisons. D''abord, d''un point de vue éthique, je pense que tous les animaux méritent de vivre librement, et l’élevage industriel entraîne souvent des conditions de vie cruelles pour eux. Ensuite, sur le plan environnemental, la production de viande génère une grande quantité de gaz à effet de serre et consomme d''énormes ressources en terres et en eau, ce qui accélère le changement climatique et la déforestation.

Document B :
Alain : 
 Je pense que la consommation de viande reste justifiée, car elle fournit des nutriments essentiels comme les protéines, les vitamines B, le fer et le zinc. Bien qu''il soit possible de trouver ces éléments dans des sources végétales, ils sont souvent mieux assimilés par l''organisme lorsqu''ils proviennent de la viande. De plus, la viande joue un rôle clé dans de nombreuses cultures et traditions culinaires, ce qui renforce son importance au-delà de la simple nutrition. Toutefois, il est important de choisir de la viande provenant de pratiques d’élevage responsables, respectueuses de l''environnement et du bien-être animal.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_095',
  'Thème du débat : « Végétarisme : Un Choix à Réfléchir »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Le végétarisme offre plusieurs bénéfices. Il contribue d''abord à une meilleure santé en réduisant les risques de maladies, telles que les problèmes cardiaques, grâce à la consommation de fruits et de légumes. En outre, il joue un rôle dans la protection de l''environnement en réduisant la pollution liée à la production de viande. Enfin, il permet de respecter les animaux, un principe de plus en plus soutenu par les Européens.

Document B :
Le végétarisme ne convient pas à tout le monde. Certaines personnes ont besoin de viande pour obtenir des nutriments essentiels, comme le fer et les protéines. De plus, les habitudes alimentaires traditionnelles en Europe incluent souvent la viande, ce qui rend ce changement difficile. Enfin, adopter un régime végétarien peut demander plus de temps et de connaissances pour équilibrer correctement les repas, ce qui peut ne pas être pratique pour tous.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_096',
  'Thème du débat : « L''impact des grands événements sportifs »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
L''organisation par l''État d''événements sportifs majeurs comme les Jeux Olympiques, la Coupe du Monde ou la Coupe d''Afrique représente une opportunité exceptionnelle. C''est une occasion unique de promouvoir notre culture à l''échelle mondiale et de capter l''attention internationale. De plus, ces compétitions stimulent l''économie locale par la création d''emplois et la modernisation des infrastructures, ce qui engendre des bénéfices durables pour toute la population.

Document B :
Organiser de grands événements sportifs engendre des coûts importants pour l''État. Il serait plus judicieux d''investir les fonds publics en priorité dans la santé et l''éducation. L''expérience montre que ces compétitions peuvent endetter les pays hôtes sans apporter de bénéfices concrets à la population.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_097',
  'Thème du débat : « Interdiction de la circulation en zones urbaines : Avantages et défis »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Face à une pollution croissante, certaines villes ont mis en place des interdictions de circulation en centre-ville. Par exemple, Oslo a appliqué cette mesure avec succès, réduisant ainsi le taux d’accidents et la dépendance au pétrole, tout en améliorant la qualité de l’air.

Document B :
Si l’interdiction des voitures en zone urbaine a des avantages, elle pose aussi des défis. Beaucoup de villes ne disposent pas encore d’une infrastructure adaptée pour assurer une transition efficace. Il est essentiel de prévoir des parkings, de renforcer les transports en commun et de permettre la circulation de certains services essentiels comme les ambulances et les livraisons.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_098',
  'Thème du débat : « Les menus sans viande dans les cantines scolaires »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Motivées par des questions de santé et des études montrant que les enfants consomment trop de protéines animales, de plus en plus d''écoles introduisent des menus sans viande au moins deux fois par semaine. Elles remplacent la viande par des options comme le soja, les céréales ou les légumes, jugées moins grasses et bénéfiques pour la croissance. Cette initiative, qui réduit aussi le coût des repas pour les familles, est bien accueillie par les parents et les enfants.

Document B :
L''idée de supprimer la viande des cantines est loin de faire l''unanimité et soulève plusieurs critiques. D''une part, elle pénalise les enfants de familles modestes pour qui la cantine est parfois le seul moyen d''accéder à la viande, un produit cher. D''autre part, les producteurs de viande locaux, qui dépendent des commandes des cantines, expriment leur mécontentement face à cette perte financière. Enfin, beaucoup d''enfants eux-mêmes affirment préférer le goût de la viande, comme le steak de bœuf, aux substituts tels que le soja, qu''ils jugent insipides.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_099',
  'Thème du débat : « Les vols à bas prix »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Je voyage fréquemment avec des compagnies aériennes à bas prix. Ces compagnies low-cost proposent des billets bien moins chers que ceux des compagnies classiques, parfois même plus économiques que le train ou la voiture. Évidemment, à ces prix-là, les services à bord sont inexistants : pas de repas ni de boissons. À mon avis, ce type de vol n’est pas adapté aux longs trajets.

Document B :
J''ai décidé de ne plus emprunter les compagnies aériennes low-cost. Après réflexion, ce choix s''impose face à l''inconfort des sièges, aux conditions de travail difficiles et aux doutes sur la sécurité liés à la vétusté des avions. Je privilégierai donc la voiture ou le train pour certains trajets, ce dernier offrant de beaux paysages et les compagnies régulières pour les vols long-courriers.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_100',
  'Thème du débat : « Caméras de surveillance à l''école : pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Dans l’établissement où j’enseigne à Montréal, les caméras de surveillance sont très présentes. Elles jouent un rôle dissuasif en réduisant les comportements violents parmi les élèves. Leur installation est bien accueillie par les enseignants, les parents et la majorité des élèves, car elle renforce le sentiment de sécurité et permet de travailler sereinement. Cependant, quelques élèves estiment que leur vie privée est compromise.

Document B :
Je suis défavorable à l’installation de caméras de surveillance dans les écoles de Montréal. Les expériences menées dans d''autres pays ne démontrent pas clairement leur efficacité. Ces dispositifs, bien que très visibles, peuvent facilement être contournés par ceux qui souhaitent nuire. À mon avis, les problèmes de discipline devraient être traités en renforçant le dialogue entre les enseignants, les élèves et l’administration. Il est aussi essentiel de faire comprendre et respecter le règlement intérieur, plutôt que de s’en remettre à la surveillance.',
  NULL,
  true
);

INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
(
  'expression_ecrite',
  3,
  'EE_T3_101',
  'Thème du débat : « Impact des vêtements de marque sur les enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les vêtements de marque occupent une place importante dans la vie des enfants et des adolescents, car ils leur permettent d’exprimer leur identité et de se sentir acceptés par leurs pairs. Cette attirance est particulièrement marquée chez les adolescents, désireux d’affirmer leur personnalité. Quant aux plus jeunes, ils aiment porter des habits avec les logos ou personnages de dessins animés qu’ils affectionnent.

Document B :
Les enfants grandissent à une vitesse fulgurante, ce qui fait que leurs vêtements ne leur vont plus très longtemps. En plus de cela, leurs jeux en plein air avec leurs camarades abîment souvent leurs habits : entre taches d’herbe, accros et trous, les vêtements se détériorent rapidement.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_102',
  'Thème du débat : « Réduction du temps de travail »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Un temps de travail allégé offre aux employés l’opportunité de trouver un meilleur équilibre entre leur vie personnelle et leur activité professionnelle. Ils peuvent ainsi accorder plus d’attention à leur entourage, à leurs centres d’intérêt et à leur santé, ce qui contribue à un mieux-être global et à une efficacité accrue au travail.

Document B :
La diminution du temps de travail peut représenter un atout pour les entreprises : elle permet de réduire les absences et de mieux conserver les talents. Des employés disposant d’une plus grande flexibilité sont souvent plus investis. Néanmoins, cette transition exige une restructuration efficace des processus afin d’assurer la continuité de l’activité.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_103',
  'Thème du débat : « Les enfants face aux nouvelles technologies »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La technologie peut être utilisée par les enfants du primaire pour explorer des vidéos en lien avec leurs apprentissages scolaires ou pour s’exercer à travers des jeux qui développent leurs capacités en calcul, en lecture ou en écriture au clavier.

Document B :
Les technologies modernes encouragent une attitude passive chez les enfants, ce qui préoccupe beaucoup de parents. Elles limitent les interactions humaines, les jeux imaginatifs et l’exercice physique. Pourquoi ne pas introduire des activités originales et engageantes pour les aider à se déconnecter ?',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_104',
  'Thème du débat : « L’agrandissement des villes »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Aujourd’hui, les villes continuent de croître à un rythme rapide, ce qui entraîne de graves répercussions sur l’environnement. En effet, plus une ville s’étend, plus elle nuit à la nature, avec des conséquences indirectes sur la santé humaine. La déforestation est l’un des impacts les plus alarmants, car les plantes jouent un rôle crucial dans l’absorption du carbone. Or, la construction urbaine remplace souvent ces espaces verts, réduisant ainsi leur capacité à limiter le réchauffement climatique.

Document B :
La majorité de la population mondiale vit aujourd’hui en zone urbaine, en particulier dans les pays développés où cela concerne huit personnes sur dix. Cela fait de la ville un véritable défi écologique. On affirme souvent que les villes sont mal conçues d’un point de vue environnemental, et que leur croissance ne fait qu’amplifier les problèmes. Toutefois, il convient de relativiser : les villes ne sont pas systématiquement les pires ennemies de la planète. En réalité, la consommation d’énergie d’un citadin est souvent inférieure à celle d’un habitant de la campagne.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_105',
  'Thème du débat : « Faut-il se faire livrer les repas au travail ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La livraison de repas en entreprise offre un gain de temps considérable aux employés. Ils n’ont plus besoin de quitter leur lieu de travail pour chercher de quoi manger. De plus, les économies réalisées en temps et en énergie permettent d’améliorer la productivité. Les repas étant directement disponibles, il est possible de les consommer après une réunion ou une conférence, sans interrompre une tâche importante. Cette solution est particulièrement adaptée aux entreprises à forte activité, où la présence continue des employés est essentielle.

Document B :
La popularité croissante de cette pratique n’est pas sans inconvénients. En effet, certains jours, les livreurs peuvent être débordés par un volume important de commandes, ce qui accentue le stress lié aux délais. Quant aux salariés, s’ils ne prennent pas le temps de quitter leur poste pour le repas, cela peut entraîner une fatigue accrue. Il est donc essentiel d’intégrer des pauses régulières pendant les périodes de travail soutenu.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_106',
  'Thème du débat : « Caméras de surveillance : utile ou excessive ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Avec l’essor des caméras dans les villes, la vidéosurveillance devient de plus en plus courante. Les Français y sont majoritairement favorables, y voyant un moyen d’améliorer la sécurité. Un sondage révèle que 75 % d’entre eux approuvent son déploiement. 
 Toutefois, ils acceptent cette surveillance uniquement dans les lieux publics : rues, magasins, transports en commun. En revanche, ils sont opposés à l’idée d’être observés par leur employeur. En France, la surveillance au travail reste très limitée.

Document B :
D’après plusieurs enquêtes, la vidéosurveillance est onéreuse et son efficacité contestée. Comme les caméras sont visibles, elles ne permettent pas d''empêcher efficacement les délits tels que les vols, les violences urbaines ou la consommation de drogues. De surcroît, leur gestion est complexe : une étude menée en Allemagne indique qu’il faut mobiliser jusqu’à sept personnes pour exploiter les images provenant d’une seule caméra.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_107',
  'Thème du débat : « Livraison de repas »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Bonjour, 
 Vous avez pris des cours dans notre salle de sport. 
 Donnez-nous votre avis sur notre site Internet ! 
 www.masalledesport.org

Document B :
Sur le site Internet de la salle de sport, vous répondez à ce message. Vous racontez cette expérience et vous donnez votre avis .',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_108',
  'Thème du débat : « Vivre En Colocation »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vivre en colocation présente de nombreux avantages. Partager un logement avec d’autres permet de réduire les dépenses, comme le loyer, les factures et autres charges. En outre, cela favorise les interactions sociales et les échanges culturels. La colocation offre l’opportunité de rencontrer des personnes de divers horizons, de tisser des liens d’amitié et de vivre des expériences enrichissantes.

Document B :
La colocation peut comporter des inconvénients. Des désaccords peuvent survenir en raison des différences de personnalités ou de modes de vie. Le manque de clarté dans la gestion des tâches ménagères peut aussi générer des tensions. Enfin, le partage de l’espace peut limiter l’intimité. Pour que la vie en colocation se passe bien, il est important de discuter ouvertement, de respecter les autres et de mettre en place des règles communes.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_109',
  'Thème du débat : « Les billets d’avion à prix réduits »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Je privilégie souvent les compagnies aériennes à bas prix pour mes voyages. Elles proposent des tarifs bien inférieurs à ceux des compagnies traditionnelles, parfois même plus avantageux que le train ou la voiture. Cependant, ces prix attractifs impliquent l’absence de services à bord : pas de repas ni de boissons inclus. À mon avis, le low-cost est une excellente solution pour les courts trajets, mais peu adapté aux vols long-courriers.

Document B :
Après y avoir longuement pensé, j’ai choisi de ne plus voyager avec les compagnies aériennes à bas prix. Les sièges sont trop inconfortables, les conditions de travail du personnel sont préoccupantes et, surtout, la sécurité des avions laisse parfois à désirer. Pour les courts trajets, je privilégierai désormais la voiture ou le train, qui offre en plus une belle vue sur les paysages. Pour les longs vols, rien ne vaut le confort d’une compagnie classique.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_110',
  'Thème du débat : « Faire ses courses : épiceries locales ou supermarchés ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Grâce à leur vaste assortiment, les supermarchés permettent de faire ses achats en un seul lieu. Stationner y est aisé, et les clients peuvent parcourir les rayons pour comparer les marques et profiter de promotions régulières sur divers produits.

Document B :
Soutenir les petits commerces : le défi « Février sans supermarché » 
 Lancé pour contrer la domination des grandes surfaces, ce défi encourage les consommateurs à privilégier les commerces de proximité durant un mois. En achetant dans les épiceries de quartier, les clients profitent de produits plus frais et de qualité tout en renforçant les liens sociaux avec leurs voisins.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_111',
  'Thème du débat : « Sévérité parentale : atout ou frein ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
À presque 22 ans, je vis encore chez mes parents, mais leur autorité reste omniprésente. Lorsque j’étais mineure, il m’était interdit de dormir ailleurs et je devais rentrer avant 21h après une sortie entre amies. Aujourd’hui, bien que je puisse sortir plus tard, ma mère m’appelle constamment jusqu’à mon retour à la maison.

Document B :
Les parents redoutent parfois d’être trop stricts avec leurs enfants, craignant que cela freine leur épanouissement et leur confiance en eux. Pourtant, céder à toutes leurs demandes par amour peut aussi avoir des conséquences négatives à l’âge adulte. Il est essentiel d’inculquer dès l’enfance le respect de certaines règles nécessaires à la vie en société.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_112',
  'Thème du débat : « Les produits faits maison : un choix judicieux ou un risque ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Faire vos produits biologiques chez vous vous donne un contrôle total sur les ingrédients, offrant ainsi des alternatives plus saines et personnalisées. Vous contribuez à la réduction des déchets plastiques avec des emballages réutilisables, tout en économisant de l’argent sur le long terme et en cultivant des compétences créatives pour un mode de vie plus respectueux de l’environnement.

Document B :
Bien que fabriquer soi-même des produits bio soit une option intéressante, cela comporte des risques. Une mauvaise formulation peut aboutir à des produits inutiles ou irritants pour la peau. Trouver et préparer les bons ingrédients demande aussi du temps et des efforts. De plus, il n''existe aucune certitude quant à la stabilité des produits faits maison, avec des risques de contamination si les produits ne sont pas stockés correctement. Le coût élevé des ingrédients de qualité peut également décourager certains.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_113',
  'Thème du débat : « Écoles privées ou publiques : quel choix faire ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les écoles privées enregistrent une hausse constante d’inscriptions en France. Ce succès repose principalement sur leur image et non sur les performances académiques. Les parents apprécient la discipline et la proximité avec les enseignants, qui y sont souvent perçus comme plus investis. De plus, ces établissements accueillent majoritairement des élèves issus de milieux aisés, ce qui contribue à leur homogénéité sociale. Toutefois, leur coût élevé les rend moins accessibles que les écoles publiques.

Document B :
L’accès aux collèges privés reste limité aux familles pouvant assumer les coûts de scolarité, ce qui empêche les élèves issus de milieux modestes d’y être représentés. Cette séparation entre privé et public freine la mixité sociale et réduit les opportunités d’échanges entre jeunes de différentes origines. En conséquence, ce modèle scolaire perpétue les inégalités et renforce les écarts entre les catégories sociales.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_114',
  'Thème du débat : « Les devoirs à domicile : un atout ou une contrainte ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Selon certains parents d’élèves, les devoirs sont bénéfiques, car ils enseignent aux enfants à organiser leur travail. De plus, ils offrent aux familles un moment d’échange avec l’école. Malgré la fatigue de la journée, ce suivi permet aux parents de montrer à leurs enfants qu’ils s’intéressent à leur progression, ce qui est très valorisant pour eux.

Document B :
Nous remettons en question l’utilité des devoirs à domicile, car ils ne garantissent pas de meilleurs résultats scolaires. De nombreux parents ne peuvent pas superviser le travail de leurs enfants, soit par manque de temps, soit par manque de connaissances. De plus, les élèves autonomes n’en ont pas besoin, et ceux qui ne sont pas aidés restent pénalisés. C’est pourquoi nous pensons que les devoirs devraient être supprimés.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_115',
  'Thème du débat : « Les nouvelles technologies à l’école : un atout ou un risque ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Jean : À mon avis, intégrer les nouvelles technologies dans l’éducation est indispensable pour préparer les élèves à l’ère du numérique. L’usage des outils comme les tablettes et les ordinateurs renforce leur motivation, enrichit leur apprentissage et leur permet d’accéder facilement à divers supports, favorisant ainsi leur autonomie et leur créativité.

Document B :
Sara : L’usage excessif des technologies dans l’enseignement me laisse perplexe. Je pense qu’il pourrait nuire aux relations humaines essentielles et accentuer l’addiction aux écrans. Pour moi, l’enseignement traditionnel et le lien direct entre élèves et enseignants sont irremplaçables pour assurer un développement harmonieux des compétences.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_116',
  'Thème du débat : « L’attrait des grandes marques vestimentaires »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Pour les enfants et les adolescents, porter des vêtements de marque est une façon d’afficher leur personnalité et de renforcer leur appartenance à un groupe. Les adolescents, en particulier, y voient un moyen d’explorer et d’affirmer leur identité. Quant aux plus jeunes, ils sont souvent attirés par des vêtements représentant leurs héros de dessins animés ou arborant des logos familiers.

Document B :
La croissance rapide des enfants fait que leurs vêtements deviennent vite trop petits. En outre, leurs jeux en extérieur, que ce soit avec leurs amis ou dans des espaces verts, entraînent une usure accélérée des tissus, les rendant souvent sales ou troués.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_117',
  'Thème du débat : « Les animaux de compagnie sont-ils bénéfiques pour les enfants ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
L’adoption d’un animal par un enfant présente plusieurs atouts, selon les experts. Il constitue un compagnon réconfortant, notamment pour les enfants qui grandissent sans frères ni sœurs. En s’occupant de lui, l’enfant apprend à respecter les besoins d’un être vivant et gagne en confiance. De plus, la présence de l’animal lui procure un sentiment de sécurité et l’encourage à devenir plus autonome.

Document B :
Il est fréquent qu’un enfant réclame un animal de compagnie, notamment un chien ou un chat. Toutefois, avant de répondre à cette demande, une réflexion approfondie s’impose. Accueillir un animal signifie s’engager pour plusieurs années, tant sur le plan financier qu’émotionnel. Son bien-être dépend de soins constants, et il ne doit jamais être perçu comme un jouet dont on peut se séparer à la première occasion.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_118',
  'Thème du débat : « Les bienfaits de la lecture pour les plus jeunes »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
À l’ère du numérique, les nouvelles technologies prennent une place grandissante dans la vie quotidienne, détournant de nombreux enfants de la lecture. Jeux vidéo, sport, musique ou encore réseaux sociaux captivent leur attention bien plus que les livres. Contrairement aux générations précédentes, qui avaient pour habitude de lire abondamment, les jeunes d’aujourd’hui sont davantage attirés par des loisirs modernes influencés par des figures emblématiques du sport et du divertissement. Dès lors, faut-il leur imposer la lecture ? Comme le rappelle un proverbe, « Le goût de la lecture ne peut être forcé ». Il est donc essentiel de leur laisser la liberté de choisir ce qu’ils souhaitent lire, sans contrainte.

Document B :
La lecture a toujours été un héritage transmis de génération en génération. Cependant, ces dernières années, les livres ont peu à peu laissé place aux écrans des smartphones et des tablettes chez les enfants. Lire régulièrement permet pourtant aux jeunes d’acquérir plus facilement le langage, tout en développant leur attention et leur capacité d’écoute. Afin d’allier apprentissage et plaisir, les parents peuvent accorder dix minutes par jour à la lecture avec leurs enfants, un rituel bénéfique qui renforce les liens familiaux.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_119',
  'Thème du débat : « L''usage des nouvelles technologies en milieu scolaire : avantages et inconvénients »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Jean : Je suis persuadé que l’introduction des nouvelles technologies dans les écoles est indispensable pour familiariser les élèves avec l’univers numérique. L’usage des outils numériques, comme les tablettes et les ordinateurs, renforce leur motivation et améliore leur apprentissage en leur offrant des ressources variées qui encouragent leur indépendance et leur imagination.

Document B :
Sara : Je suis partagée sur l’intégration poussée des technologies dans l’éducation. À mon sens, cela pourrait nuire aux interactions sociales et accentuer une addiction aux écrans. L''enseignement traditionnel, basé sur un échange direct entre professeurs et élèves, demeure primordial pour garantir un développement harmonieux des compétences des jeunes.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_120',
  'Thème du débat : « Les Travaux Scolaires à Domicile »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les devoirs à domicile jouent un rôle important selon les associations de parents d’élèves, car ils encouragent l’autonomie des enfants dans la gestion de leur emploi du temps. Pour les parents, c’est aussi un moyen de rester connectés à la vie scolaire de leurs enfants. Même si cela demande un effort après une longue journée de travail, ils apprécient ces instants partagés, source de valorisation pour les enfants.

Document B :
Depuis longtemps, nous contestons les devoirs à la maison pour diverses raisons. Leur impact positif sur la réussite des élèves n’a jamais été prouvé. De plus, tous les parents ne sont pas en mesure d’aider leurs enfants, soit par manque de temps, soit par manque de compétences. Les élèves qui réussissent déjà en classe n’en retirent aucun bénéfice, et ceux qui n’ont pas d’accompagnement à domicile continuent de rencontrer des difficultés. C’est pour cela que nous demandons la suppression des devoirs à la maison.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_121',
  'Thème du débat : « Faut-il choisir une école privée ou publique ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les écoles privées connaissent une augmentation du nombre d’inscriptions en France lors de chaque rentrée scolaire. Leur attractivité ne repose pas seulement sur la réussite académique, mais aussi sur leur renommée. Beaucoup de parents estiment que leurs enfants y sont mieux encadrés et bénéficient d’un suivi plus rigoureux. Ces établissements, accessibles moyennant des frais de scolarité, regroupent principalement des élèves de milieux favorisés, ce qui représente un critère important pour certaines familles.

Document B :
Dans les établissements privés, la présence d’élèves issus de milieux défavorisés est limitée. En raison des coûts de scolarité, ces écoles ne sont pas accessibles à toutes les familles, ce qui accentue la séparation avec les écoles publiques. Cette situation empêche la mixité sociale et prive les élèves de rencontres enrichissantes avec des jeunes d’horizons divers. Ce modèle éducatif perpétue ainsi les inégalités et renforce le sentiment d’exclusion.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_122',
  'Thème du débat : « Produits Maison : Une Alternative Intéressante ou une Contrainte ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Préparer ses produits biologiques à la maison offre un contrôle total sur leur composition, garantissant des solutions saines et adaptées. Cette pratique permet aussi de limiter l’usage de plastique grâce à des emballages réutilisables. Elle représente une alternative économique et enrichissante qui favorise un mode de vie plus responsable et écologique.

Document B :
La production de produits biologiques maison n’est pas sans inconvénients. Une erreur dans la formulation peut altérer leur efficacité ou provoquer des réactions indésirables. De plus, rassembler et préparer les ingrédients peut être fastidieux. L’absence de certification garantit moins de sécurité et favorise le risque de contamination bactérienne en cas de mauvaise conservation. Enfin, l’investissement de départ pour des ingrédients de qualité peut être un obstacle pour certains.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_123',
  'Thème du débat : « Location Courte Durée »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Offrant flexibilité et confort, la location courte durée est une option pratique pour les voyageurs. Elle permet de louer un logement pour un temps limité, idéal pour des vacances ou des déplacements professionnels, tout en bénéficiant d''un hébergement adapté aux besoins spécifiques et sans engagement à long terme

Document B :
Dans les zones touristiques, la location courte durée peut parfois être coûteuse et la disponibilité restreinte, en particulier lors des périodes de haute affluence. Il est donc essentiel de planifier à l''avance et de réserver pour obtenir les meilleures options.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_124',
  'Thème du débat : « La question des caméras de surveillance dans les écoles : Pour ou contre cette mesure ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Dans l’établissement où j’enseigne à Montréal, les caméras de surveillance sont présentes partout. Leur installation vise à prévenir les comportements violents chez les élèves. Les enseignants, les parents et une grande majorité des élèves soutiennent leur présence, se sentant ainsi plus rassurés concernant la sécurité des enfants, et permettant aux enseignants de travailler dans un environnement plus serein. Cependant, certains élèves estiment que cela empiète sur leur vie privée.

Document B :
Je suis contre l''usage des caméras de surveillance dans les écoles à Montréal. Les exemples d''autres pays ne montrent pas d''efficacité réelle, et les caméras peuvent facilement être contournées. Selon moi, les problèmes disciplinaires devraient être réglés par une meilleure communication entre les enseignants, les administrateurs et les élèves, ainsi qu’une sensibilisation continue au respect des règles. Les caméras ne sont qu’une solution superficielle et ne favorisent pas un climat de confiance ni de coopération au sein de l’établissement.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_125',
  'Thème du débat : « Tenue uniforme à l''école »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
L’uniforme à l’école favorise le sentiment d''appartenance à une communauté et renforce le collectif. Il permet de réduire les discriminations fondées sur les vêtements ou le statut social. Cela est particulièrement avantageux pour les familles qui ne peuvent pas se permettre d’acheter des vêtements de marque, rendant ainsi l’école plus équitable.

Document B :
L’uniforme scolaire prive les élèves de la possibilité de se distinguer par leurs choix vestimentaires, ce qui peut être perçu comme une restriction de leur liberté d’expression. En effet, ceux qui aiment exprimer leur personnalité à travers la mode se sentiront limités et contraints par les règles de l’uniforme, qui les empêche de se démarquer, même avec un simple accessoire ou vêtement distinctif.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_126',
  'Thème du débat : « Les Habits de Marques Réputées »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les vêtements de marque occupent une place essentielle dans la vie des enfants et des adolescents. Ils constituent un moyen d’expression et d’appartenance à un groupe social. Chez les adolescents, cette préférence est particulièrement marquée, car elle leur permet d''affirmer leur personnalité. De leur côté, les plus jeunes apprécient les vêtements ornés des personnages de leurs dessins animés favoris ou arborant des logos qu’ils affectionnent.

Document B :
Les enfants grandissent à une telle vitesse que leurs vêtements deviennent vite trop petits. En plus de cela, leurs activités en plein air, comme jouer dans l’herbe ou sur une aire de jeux, accélèrent l’usure des habits, qui se salissent rapidement ou finissent par se déchirer.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_127',
  'Thème du débat : « La restauration express »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les restaurants express offrent des plats équilibrés et variés, tout en respectant les normes d''hygiène et en proposant une gamme diversifiée de produits de qualité. De plus, c''est le client qui compose son menu, assumant ainsi la responsabilité de ses choix.

Document B :
La restauration express est nocive pour la santé, car elle engendre des problèmes irréversibles, comme l''obésité.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_128',
  'Thème du débat : « Les cours de langues en ligne »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Grâce à Internet, il est tout à fait possible d’apprendre une langue en ligne et d’obtenir de bons résultats. Contrairement aux formations classiques, ces cours offrent une grande flexibilité : on peut étudier à n’importe quel moment de la journée, sans avoir à se déplacer. Cet apprentissage à distance permet non seulement un gain de temps, mais aussi des économies financières.

Document B :
Bien que les cours en ligne semblent être une solution idéale, ils ne conviennent pas à tout le monde. Il est nécessaire d’avoir une connexion Internet stable et un équipement adapté (ordinateur, smartphone, tablette). De plus, apprendre seul demande une grande autonomie et une discipline rigoureuse. Sans professeur ni camarades de classe pour motiver, il est facile de perdre son enthousiasme et d’abandonner rapidement.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_129',
  'Thème du débat : « Les bienfaits des animaux de compagnie pour les enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Offrir un animal de compagnie à un enfant peut être très bénéfique, selon de nombreux psychologues. Pour un enfant sans frères et sœurs, l’animal devient un compagnon précieux qui l’aide à lutter contre la solitude. Il lui permet également de développer sa confiance en lui et de comprendre l’importance des soins et du respect envers un être vivant. En présence de son animal, l’enfant se sent rassuré et apprend progressivement à être plus autonome dans son quotidien.

Document B :
De nombreux enfants expriment un jour le désir d’avoir un animal de compagnie, généralement un chien ou un chat. Cependant, avant de céder à cette demande, il est essentiel d’y réfléchir attentivement. Un animal devient un véritable membre de la famille et implique un engagement sur plusieurs années. Son entretien peut représenter un coût important et demande une responsabilité constante. Il ne s’agit pas d’un simple jouet dont on peut se débarrasser une fois que l’enfant perd son intérêt.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_130',
  'Thème du débat : « Le cyclisme urbain »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Le vélo évoque instinctivement deux aspects : le sport et les loisirs. Pourtant, il est fréquent d''oublier qu''il constitue avant tout un moyen de déplacement quotidien, tant pour les trajets personnels que professionnels. En milieu urbain, il se révèle non seulement rapide, mais aussi apaisant, offrant une échappatoire au trafic saturé aux heures de pointe. Une solution idéale pour allier activité physique et déplacements utiles, mêlant ainsi efficacité et plaisir.

Document B :
Circuler à vélo en milieu urbain comporte des risques non négligeables, comme en témoignent les accidents routiers recensés chaque année. La concentration élevée de véhicules, les manquements aux règles de circulation et l’insuffisance des infrastructures cyclables créent un environnement dangereux pour les usagers. À ces dangers s’ajoute l’exposition quotidienne aux polluants atmosphériques, tels que le monoxyde de carbone, dont les effets toxiques sur la santé sont avérés. Ainsi, le cyclisme en ville soulève une double problématique : sécuritaire et sanitaire.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_131',
  'Thème du débat : « L''enseignement à domicile »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Rédigez un message sur le forum d''Air Tropiques dans lequel vous décrivez votre voyage le plus mémorable (date, destination, activités, etc.) et expliquez en quoi cette expérience a été particulièrement spéciale pour vous.

Document B :
Les raisons qui poussent les parents à choisir la scolarisation à domicile sont multiples. Ce mode d''enseignement permet d''adopter une approche pédagogique plus personnalisée, offrant la possibilité de consacrer davantage de temps aux difficultés spécifiques de l''enfant ou de lui proposer, de temps à autre, des activités éducatives ludiques. Ainsi, l''enfant peut gérer son apprentissage à son propre rythme, approfondir les sujets qui le passionnent et ne pas subir la pression des progrès inégaux de ses camarades. De plus, l''instruction à domicile présente un autre avantage : une évolution différente, caractérisée par l''absence de notes parfois décourageantes, un suivi continu des connaissances et l''élimination du stress lié aux évaluations et aux devoirs.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_132',
  'Thème du débat : « Faut-il faire ses courses chez les producteurs locaux ou au supermarché ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez publié une annonce en ligne pour louer votre appartement. Rédigez un courriel afin de fournir des informations sur le logement et le quartier .

Document B :
Jean, installé à la campagne, préfère acheter ses produits alimentaires directement à la ferme pour leur qualité, même si cela lui coûte un peu plus cher.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_133',
  'Thème du débat : « Le livre papier ou le livre numérique ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Tu fais partie d’une association de quartier qui organise des activités pour les enfants (soutien scolaire, sorties, jeux, etc.). Sur le site internet de l’association, tu partages ton expérience et expliques en quoi ce type d’initiative est bénéfique.

Document B :
Depuis plusieurs années, de nombreux lecteurs ont choisi d’opter pour les livres numériques plutôt que les bibliothèques traditionnelles. Selon eux, cet outil est avant tout économique : il permet de réduire la consommation de papier et son coût est généralement inférieur à celui des livres imprimés. De plus, les livres numériques offrent des options qui facilitent l’accès à la lecture, notamment pour les personnes malvoyantes grâce à l’ajustement de la taille du texte.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_134',
  'Thème du débat : « L’utilisation du plastique : Faut-il continuer à l’utiliser ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez récemment visité un nouveau pays pendant vos vacances. Sur un site internet, vous partagez votre expérience en détaillant votre séjour et en exprimant votre opinion sur ce pays.

Document B :
Franck défend une utilisation restreinte du plastique, soulignant son importance dans des domaines tels que l’alimentation et la médecine. Il met en avant le rôle essentiel du plastique dans la conservation des produits alimentaires et la stérilisation des équipements médicaux. Bien qu’il prône une gestion responsable et le recyclage, il admet que certains usages sont inévitables dans la société moderne.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_135',
  'Thème du débat : « Rôle De La Télévision Dans L’éducation Des Enfants. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Rédigez un article de blog dans lequel vous racontez votre arrivée dans un pays étranger. Partagez vos premières impressions, vos découvertes et vos éventuelles difficultés d’adaptation .

Document B :
La télévision est un média largement présent dans notre société. Elle influence à la fois les individus et la culture en général. En plus de diffuser des informations, elle propose divers programmes de divertissement et contribue à la transmission de la culture. Présente dans de nombreux foyers, elle constitue une source accessible de savoir et de loisirs. Grâce à sa large audience, la télévision joue un rôle essentiel dans l’éducation, la diffusion des connaissances et la sensibilisation aux enjeux sociaux.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_136',
  'Thème du débat : « Livraison Des Repas Au Bureau : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Rédigez un article de blog dans lequel vous racontez votre participation à un cours de sport dans une salle. Décrivez votre expérience, donnez votre avis sur la salle et partagez vos impressions sur l’ambiance, l’équipement et l’encadrement .

Document B :
La livraison de repas en entreprise offre un gain de temps considérable aux employés. Ils n’ont plus besoin de quitter leur lieu de travail pour chercher de quoi manger. De plus, les économies réalisées en temps et en énergie permettent d’améliorer la productivité. Les repas étant directement disponibles, il est possible de les consommer après une réunion ou une conférence, sans interrompre une tâche importante. Cette solution est particulièrement adaptée aux entreprises à forte activité, où la présence continue des employés est essentielle.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_137',
  'Thème du débat : « Cuisinier Amateur Ou Cuisinier Professionnel ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Sur votre blog, partagez votre expérience d’apprentissage d’une langue étrangère. Rédigez un message sur un forum internet en racontant votre parcours et les défis rencontrés en apprenant cette langue.

Document B :
Les amateurs réussissent certaines recettes, mais il leur manque souvent les compétences et les techniques nécessaires. C’est pourquoi la formation et l’expérience sont indispensables pour devenir un véritable cuisinier.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_138',
  'Thème du débat : « Vivre En Colocation »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Rédigez un article de blog pour exprimer votre admiration envers une personnalité, qu''elle soit célèbre ou non. Mettez en avant ses actions spécifiques et expliquez pourquoi vous l''appréciez tant .

Document B :
Vivre en colocation présente de nombreux avantages. Partager un logement avec d''autres permet de réduire les dépenses, comme le loyer, les factures et autres charges. En outre, cela favorise les interactions sociales et les échanges culturels. La colocation offre l''opportunité de rencontrer des personnes de divers horizons, de tisser des liens d''amitié et de vivre des expériences enrichissantes.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_139',
  'Thème du débat : « Le Travail : Favorable ou Défavorable ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Abandonner tout pour partir en voyage pendant un an : est-ce une bonne ou une mauvaise décision ?

Document B :
Répondez sur notre site Internet à l''adresse : ''voyage.internaute.fr''. Rédigez un message pour répondre à la question en partageant des exemples tirés de votre propre expérience.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_140',
  'Thème du débat : « Les Relations Amicales Au Travail »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
« Bonjour, bonne nouvelle ! J’ai enfin obtenu mon visa pour le Canada. Mon arrivée est prévue pour le 3 mars. Pourrais-tu m’aider à trouver un hôtel pour ma première semaine sur place ? Merci beaucoup pour ton aide ! »

Document B :
Vous avez réservé un hôtel pour Matthias et lui envoyez un courriel contenant une description détaillée de l’établissement ainsi que toutes les informations essentielles, telles que son emplacement, le prix et les services proposés.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_141',
  'Thème du débat : « Choix entre manger à l’extérieur ou chez soi »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Il est essentiel de trouver un juste équilibre entre amitié et professionnalisme au travail. Des amitiés trop proches peuvent parfois engendrer des tensions ou des conflits, surtout lorsqu’il s''agit de prendre des décisions professionnelles. Par ailleurs, des amitiés exclusives entre certains collègues peuvent marginaliser les autres, ce qui peut affecter la cohésion et la collaboration au sein de l’équipe. Il est donc crucial de poser des limites claires et de s’assurer que les amitiés ne compromettent pas le professionnalisme, la hiérarchie ou la productivité dans l’organisation.

Document B :
Léa t''a envoyé un message pour te proposer un pique-nique samedi prochain et te demander si tu connais un endroit agréable pour les enfants et les adultes. Tu réponds en acceptant son invitation et en lui suggérant un lieu adapté pour le pique-nique, en décrivant les caractéristiques de l''endroit et en expliquant les activités possibles sur place.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_142',
  'Thème du débat : « Le livre papier ou le livre numérique ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Laura, une mère de famille de 45 ans, explique que manger au restaurant est souvent trop coûteux pour elle. Bien qu’elle aimerait parfois éviter la cuisine, le budget familial l''empêche. Elle critique également la qualité des plats au restaurant et préfère savoir exactement ce qu’elle mange en préparant les repas chez elle.

Document B :
Bernard t’informe qu’il va bientôt habiter dans ton quartier et qu’il cherche un bon marché pour faire ses courses. Tu lui réponds en lui décrivant un marché que tu apprécies particulièrement, en précisant son emplacement, ses horaires et les produits qu’on peut y trouver.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_143',
  'Thème du débat : « L’utilisation du plastique : Faut-il continuer à l’utiliser ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Le livre papier sera-t-il remplacé par son équivalent numérique ? Pour la majorité des lecteurs, la réponse est non. Le format papier possède un charme particulier : le plaisir de tourner les pages, l’odeur du livre, qu’il soit neuf ou ancien, et la possibilité d’écrire une dédicace lorsqu’on l’offre à quelqu’un. En revanche, le livre numérique peut sembler impersonnel et demande certaines compétences informatiques, ce qui peut constituer un frein pour certains.

Document B :
Barbara t''a envoyé un message pour savoir où elle pourrait déjeuner en plein air ce week-end. Tu lui réponds en décrivant un lieu agréable (parc, jardin, terrasse, etc.) et ses caractéristiques.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_144',
  'Thème du débat : « Les cours de langues en ligne »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Amicha s’oppose fermement à l’utilisation du plastique en raison de ses impacts environnementaux dévastateurs. Elle souligne la pollution des océans et la destruction des écosystèmes causée par les déchets plastiques. Selon elle, il est urgent d’adopter des alternatives écologiques et durables pour protéger l’environnement et la santé publique.

Document B :
Ali t’a envoyé un message pour savoir comment se passe ton nouveau travail et si tu en es satisfait(e). Tu lui réponds en décrivant ton emploi (lieu, ambiance, collègues, etc.) et en partageant tes impressions.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_145',
  'Thème du débat : « La restauration rapide »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Bien que les cours en ligne semblent être une solution idéale, ils ne conviennent pas à tout le monde. Il est nécessaire d’avoir une connexion Internet stable et un équipement adapté (ordinateur, smartphone, tablette). De plus, apprendre seul demande une grande autonomie et une discipline rigoureuse. Sans professeur ni camarades de classe pour motiver, il est facile de perdre son enthousiasme et d’abandonner rapidement.

Document B :
Tu aimerais assister à un festival de cinéma organisé dans ta ville. Tu écris un message à ton ami(e) pour lui proposer de t’accompagner. Tu lui donnes toutes les informations nécessaires sur l’événement, notamment les films projetés, les dates et horaires, ainsi que les tarifs d’entrée.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_146',
  'Thème du débat : « L’éducation des enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Selon les experts, une consommation régulière de repas dans les fast-foods présente un danger pour la santé. Ces établissements proposent souvent les mêmes aliments : frites, hamburgers et boissons sucrées. Ces produits sont très caloriques et dépassent les apports recommandés pour un repas. De plus, la plupart des emballages sont en plastique, ce qui contribue à une augmentation des déchets nuisibles à l’environnement.

Document B :
Ton ami(e) va bientôt célébrer son anniversaire. Tu écris un message à tes amis pour leur proposer d’acheter un cadeau commun.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_147',
  'Thème du débat : « La gratuité des musées : Pour ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Certains parents craignent d’être trop autoritaires avec leurs enfants. Ils ont peur qu’un excès de discipline nuise à leur épanouissement et freine leur développement personnel. Cependant, une éducation trop permissive peut aussi avoir des effets négatifs. En grandissant, un enfant habitué à obtenir tout ce qu’il veut pourrait rencontrer des difficultés à respecter les règles de la vie en société.

Document B :
Tu loues un appartement qui est trop grand pour toi. Tu rédiges une annonce dans un journal pour trouver un colocataire en mentionnant la superficie du logement, le type de colocataire recherché et le prix du loyer.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_148',
  'Thème du débat : « Le livre papier ou le livre numérique ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Rendre l’entrée des musées gratuite est une excellente initiative, car cela permet à tous, indépendamment de leur situation économique, d’accéder à la culture. Grâce à cette mesure, j’ai eu l’occasion de visiter plusieurs musées sans me soucier du coût. Cette gratuité favorise la transmission du patrimoine culturel et enrichit les connaissances du public.

Document B :
Bernard t’informe qu’il va bientôt habiter dans ton quartier et qu’il cherche un bon marché pour faire ses courses. Tu lui réponds en lui décrivant un marché que tu apprécies particulièrement, en précisant son emplacement, ses horaires et les produits qu’on peut y trouver.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_149',
  'Thème du débat : « Les vols à bas prix »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Je voyage fréquemment avec des compagnies aériennes à prix réduits. Ces compagnies low-cost offrent des billets bien moins chers que les compagnies traditionnelles, parfois même à un coût inférieur aux trajets en voiture ou en train. Toutefois, ces prix attractifs s’accompagnent de certaines restrictions, comme l’absence de repas et de boissons à bord. C’est une option intéressante pour les vols courts, mais peu adaptée aux longues distances.

Document B :
Récemment, j’ai décidé de ne plus utiliser les compagnies aériennes low-cost. Après mûre réflexion, j’ai pris cette décision en raison du manque de confort des sièges, des conditions de travail précaires des employés et des avions parfois vieillissants qui soulèvent des inquiétudes en matière de sécurité. Pour les courts trajets, je préfère désormais la voiture ou le train, qui permet aussi d’admirer les paysages. Quant aux vols longs courriers, je privilégie les compagnies aériennes classiques.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_150',
  'Thème du débat : « l''aide aux personnes pauvres. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Christine, 56 ans, consacre chaque hiver du temps et de l’argent pour aider les personnes sans abri. Elle considère qu’il est essentiel d’être solidaire envers ceux qui sont dans le besoin et estime que ce geste, même modeste, peut faire la différence.

Document B :
Pierre, 65 ans, estime que donner de l’argent n’est pas une solution durable. Selon lui, l’important est d’aider ces personnes à retrouver leur autonomie à travers un logement et un emploi. Il s’investit quotidiennement dans une association qui accompagne les sans-abris vers la réinsertion professionnelle.',
  NULL,
  true
);

INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
(
  'expression_ecrite',
  3,
  'EE_T3_151',
  'Thème du débat : « Vivre en colocation : avantages et inconvénients »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La colocation présente de nombreux avantages : elle permet de partager les frais de logement, de vivre une expérience sociale enrichissante et de tisser des liens avec des personnes d’horizons différents.

Document B :
Toutefois, cohabiter avec d’autres personnes peut également entraîner des tensions liées aux différences de mode de vie et au partage des responsabilités. Il est donc essentiel d’établir des règles et une bonne communication pour éviter les conflits.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_152',
  'Thème du débat : « Cuisinier amateur ou professionnel ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Bien que certains amateurs réussissent à préparer d’excellents plats, ils ne possèdent pas toujours les compétences et les techniques avancées des professionnels. Une formation et une expérience approfondie restent essentielles pour devenir un véritable chef cuisinier.

Document B :
Certains autodidactes passionnés de cuisine ont réussi à se faire un nom sur les réseaux sociaux, parfois sans formation officielle. Il existe même des amateurs devenus chefs professionnels et ayant publié des ouvrages destinés aux passionnés de cuisine à domicile.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_153',
  'Thème du débat : « L’installation de distributeurs automatiques dans les écoles : Pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Certains soutiennent l’installation de distributeurs de boissons dans les lycées, car ils offrent une alternative pratique pour les élèves qui n’ont pas le temps de se rendre à la cafétéria. De plus, ces distributeurs peuvent être approvisionnés en boissons saines et constituer une source de revenus pour les établissements scolaires.

Document B :
D’autres estiment que la présence de distributeurs dans les écoles favorise la consommation excessive de boissons sucrées, contribuant ainsi à des problèmes de santé comme l’obésité et le diabète. Ils plaident pour que les établissements encouragent plutôt des habitudes alimentaires saines.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_154',
  'Thème du débat : « Manger au restaurant ou cuisiner chez soi ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Aïcha, une jeune femme vivant seule, préfère dîner à l’extérieur plutôt que de manger seule chez elle. Pour elle, sortir au restaurant est une occasion de socialiser et de profiter de la diversité culinaire de sa ville.

Document B :
Laura, mère de famille, considère que manger au restaurant est un luxe difficilement accessible à une famille nombreuse. Elle privilégie la cuisine maison, qui est plus économique et permet de mieux contrôler la qualité des repas.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_155',
  'Thème du débat : « Livre papier ou livre numérique ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
De nombreux lecteurs ont opté pour les livres numériques, principalement pour des raisons économiques et écologiques. En effet, ces livres permettent d’économiser du papier et coûtent généralement moins cher que les versions imprimées. Ils offrent aussi des fonctionnalités adaptées aux personnes en situation de handicap, comme la possibilité d’agrandir les caractères.

Document B :
Malgré les avancées technologiques, de nombreux lecteurs restent attachés aux livres papier. La sensation de tenir un livre, son odeur, et le plaisir de l’offrir ou de l’annoter en font un objet unique. En revanche, les livres numériques peuvent sembler impersonnels et nécessitent un minimum de compétences informatiques.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_156',
  'Thème du débat : « L’impact du plastique : Pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Chaque année, des tonnes de plastique sont rejetées dans les océans, causant des dommages considérables à la faune et à la flore marines. Ces déchets menacent l’écosystème et peuvent même contaminer la chaîne alimentaire. Il est donc crucial de limiter la consommation de plastique et d’encourager des alternatives durables.

Document B :
Cependant, le plastique est un matériau essentiel dans plusieurs domaines, notamment la médecine. Il est utilisé pour fabriquer des équipements médicaux tels que des prothèses, des seringues et des implants. Grâce à ses propriétés hygiéniques et pratiques, il joue un rôle important dans la santé et la sécurité des patients.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_157',
  'Thème du débat : « Les cours de langues en ligne : avantages et inconvénients »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Grâce à Internet, il est désormais possible d’apprendre une langue sans se déplacer. Ces cours offrent une grande flexibilité, permettant aux apprenants d’étudier à leur rythme, à tout moment de la journée. De plus, cela permet de réduire les coûts de formation et d’économiser du temps.

Document B :
Toutefois, apprendre une langue en ligne n’est pas adapté à tout le monde. Il faut avoir une connexion Internet stable et un appareil approprié (ordinateur, smartphone, tablette). De plus, l’absence d’un professeur en présentiel peut nuire à la motivation et à la progression, rendant parfois l’apprentissage plus difficile.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_158',
  'Thème du débat : « Livraison de repas au bureau : pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La livraison de repas en entreprise est une solution pratique qui permet aux employés de gagner du temps en évitant de sortir pour déjeuner. Elle favorise aussi une meilleure gestion de leur emploi du temps, notamment lors de réunions ou de périodes de travail intense.

Document B :
Cependant, cette habitude peut avoir des effets négatifs. En ne quittant pas leur poste pour la pause déjeuner, les employés risquent de se fatiguer plus rapidement et de manquer d’interactions sociales. De plus, les services de livraison peuvent être débordés, ce qui entraîne des retards et un manque de diversité dans les repas proposés.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_159',
  'Thème du débat : « L’impact de la télévision sur l’éducation des enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Cependant, un usage excessif de la télévision peut avoir des effets négatifs sur les enfants. Passer trop de temps devant un écran peut limiter les interactions sociales, réduire le temps consacré à la lecture et favoriser des comportements sédentaires. Il est donc important de réguler son utilisation.

Document B :
La télévision peut également présenter certains inconvénients. Les émissions télévisées peuvent parfois véhiculer des stéréotypes, des préjugés et des valeurs discutables. De plus, le temps passé devant la télévision peut réduire le temps consacré à d’autres activités plus enrichissantes, telles que la lecture, les interactions sociales ou la pratique d’un sport. Il est important de faire preuve de discernement et de réguler l’exposition à la télévision, en particulier pour les enfants, afin de préserver un équilibre sain entre les différentes formes d’apprentissage et de divertissement.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_160',
  'Thème du débat : « L’utilisation du plastique : bénéfices et dangers »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Le plastique est un matériau essentiel dans plusieurs domaines, notamment la médecine et l’industrie alimentaire. Il est utilisé pour conserver les aliments et fabriquer des équipements médicaux stériles, améliorant ainsi la santé et la sécurité des consommateurs.

Document B :
Malgré ses avantages, le plastique représente un danger majeur pour l’environnement. Son accumulation dans les océans menace la faune marine et contribue à la pollution. Pour préserver notre planète, il est crucial de limiter son usage et de privilégier des alternatives écologiques.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_161',
  'Thème du débat : « Livre papier ou livre numérique ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
De nombreux lecteurs ont opté pour les livres numériques en raison de leur praticité et de leur prix réduit. Ils permettent de transporter une grande bibliothèque sur un appareil compact et offrent des options adaptées aux personnes en situation de handicap.

Document B :
Cependant, le livre papier conserve une place privilégiée pour beaucoup de lecteurs. La sensation de tourner les pages, l’odeur du papier et le plaisir d’offrir un livre sont des éléments qui rendent ce format irremplaçable.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_162',
  'Thème du débat : « Faut-il rendre les musées gratuits ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La gratuité des musées peut entraîner une affluence excessive et une baisse des ressources financières, compromettant l’entretien des œuvres. Une alternative serait de proposer des tarifs réduits pour favoriser l’accessibilité sans nuire aux musées.

Document B :
Permettre l’accès gratuit aux musées est une excellente initiative pour encourager la culture et l’éducation. Cela permet à un plus large public de découvrir le patrimoine sans contrainte financière.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_163',
  'Thème du débat : « Cuisinier amateur ou professionnel ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les passionnés de cuisine peuvent préparer d’excellents plats, mais ils ne possèdent pas toujours l’expertise et les techniques des chefs professionnels. Une formation et une expérience en cuisine sont nécessaires pour développer un savoir-faire précis et garantir un niveau de qualité élevé.

Document B :
Certains autodidactes se sont fait un nom grâce aux réseaux sociaux, où ils partagent leurs recettes et leurs astuces culinaires. Certains d’entre eux ont même publié des livres de cuisine et sont devenus des références pour les amateurs souhaitant progresser dans l’art culinaire.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_164',
  'Thème du débat : « Les Vêtements De Marque: Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les vêtements de marques sont très importants pour les enfants et les adolescents. C''est un moyen de s''exprimer et de se rattacher à un groupe social. Cette attirance pour les marques est très présente chez les adolescents qui se cherchent et montrent leurs personnalités. Les enfants aiment également porter des vêtements de marques avec des images des dessins animés qu''ils regardent ou des logos qu''ils apprécient.

Document B :
Les enfants grandissent très vite et les vêtements sont portés pendant une courte période. Ainsi, les vêtements deviennent rapidement trop petits. Mais il y a aussi le fait que les enfants usent assez rapidement les vêtements en jouant à l''extérieur avec les copains, en s''amusant dans l''herbe ou à l''air de jeux. Les habits sont très vite sales ou troués.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_165',
  'Thème du débat : « Uniforme Scolaire ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Le port de l’uniforme développe un sentiment d’appartenance à son établissement, et à la communauté des élèves. Il nourrit chez le jeune le sens du collectif et engendre souvent la fierté d’appartenir à son établissement. De plus, il réduit la discrimination basée sur le style ou sur la classe sociale de l’élève. En effet, l’uniforme permet aux parents d’économiser beaucoup d’argent, ce ne sont pas tous les parents griffés ou de marques populaires. La mise en place d’un code vestimentaire réduit donc les différences entre les classes sociales.

Document B :
Le port de l’uniforme étouffe et écrase la personnalité des garçons. Ils ne peuvent pas s’habiller comme ils le veulent, en aucune circonstance. De l’autre côté de l’échelle (chez les pros) il y a des gens qui préfèreraient, pour eux-mêmes et leurs enfants, avoir la possibilité de s’exprimer à travers l’habillement, en décidant eux-mêmes ce qu’ils porteront chaque jour. Ainsi, avec un uniforme, les jeunes qui aiment s’exprimer à travers I ‘habillement, en décidant eux-mêmes ce qu’ils porteront chaque jour. Ainsi, avec un uniforme, les jeunes qui aiment s’exprimer à travers la mode, se démarquer de la foule grâce à un accessoire ou un vêtement particulier se retrouveront déçus et emprisonnés dans l’uniforme.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_166',
  'Thème du débat : « Les Caméras De Surveillance A L’école : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Dans l’école où j’enseigne à Montréal, les caméras de surveillance sont omniprésentes. Leur présence permet de dissuader les élèves de commettre des actes de violence. Les enseignants, les parents et la majorité des élèves les acceptent volontiers, car ils se sentent rassurés quant à la sécurité des enfants et que cela permet aux enseignants de travailler dans de bonnes conditions. Toutefois, certains élèves considèrent que cela porte atteinte à leur vie privée.

Document B :
Je suis opposé à l’installation des caméras de surveillance dans nos écoles à Montréal. Les résultats obtenus dans les pays où ce système est utilisé ne sont pas convaincants. Les personnes mal intentionnées peuvent facilement contourner les caméras, qui sont très visibles. Les problèmes de discipline dans une école peuvent être résolus en améliorant la communication entre les enseignants, l’administration et les élèves. Il est également nécessaire de faire respecter et expliquer les règles de l’école par tous, plutôt que de recourir aux caméras.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_167',
  'Thème du débat : « Location Courte Durée ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La location courte durée offre flexibilité et commodité pour les voyageurs. Elle permet de louer un logement pour une période de temps limitée, que ce soit pour des vacances ou un déplacement professionnel. Cela permet aux voyageurs de profiter d’un hébergement confortable avec des équipements adaptés à leurs besoins, tout en évitant les engagements à long terme.

Document B :
La location courte durée peut parfois être coûteuse, en particulier dans les zones touristiques. De plus, la disponibilité peut être limitée, surtout pendant les périodes de forte demande. Il est donc important de planifier et de réserver à l’avance pour obtenir les meilleurs résultats.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_168',
  'Thème du débat : « Rôle De La Télévision Dans L’éducation Des Enfants. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La télévision est un outil de communication et de divertissement largement répandu dans notre société moderne. Son influence est incontestable, tant sur les individus que sur la culture en général. Elle permet de diffuser des informations, d’offrir des divertissements variés et de favoriser la diffusion de la culture. La télévision est présente dans de nombreux foyers et constitue une source d’information et de divertissement accessibles à tous. Grâce à sa portée et à sa capacité à toucher un large public, la télévision joue un rôle important dans la transmission des connaissances et la sensibilisation aux enjeux sociaux.

Document B :
La télévision peut également présenter certains inconvénients. Les émissions télévisées peuvent parfois véhiculer des stéréotypes, des préjugés et des valeurs discutables. De plus, le temps passé devant la télévision peut réduire le temps consacré à d’autres activités plus enrichissantes, telles que la lecture, les interactions sociales ou la pratique d’un sport. Il est important de faire preuve de discernement et de réguler l’exposition à la télévision, en particulier pour les enfants, afin de préserver un équilibre sain entre les différentes formes d’apprentissage et de divertissement.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_169',
  'Thème du débat : « Vie en colocation entre adultes. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vivre avec d’autres personnes demande d’avoir une bonne entente et de respecter certaines règles. Il n’est pas toujours possible d’écouter sa musique préférée à volume élevé, d’inviter tous ses amis pour faire la fête ou de laisser de la vaisselle sale dans la cuisine. Chaque individu a des habitudes susceptibles d’irriter les autres. C’est pourquoi il est essentiel d’établir des règles de vie en communauté et de les respecter mutuellement. Il est important de communiquer avec ses colocataires chaque fois qu’un problème survient. L’organisation et la discussion sont les clés d’une colocation réussie ou non.

Document B :
Être adulte et vivre en colocation ? C’est un choix qui permet d’accéder facilement à un logement plus spacieux et économique. Il est vrai que vous n’aurez qu’une chambre pour vous et que vous devrez partager la cuisine, le salon et la salle de bain. Toutefois, une colocation peut inclure une maison avec jardin ou un grand appartement en centre-ville ! De plus, en partageant le loyer et les charges avec vos colocataires, vous réduirez considérablement vos dépenses par rapport à un appartement individuel. Alors que vous n’aurez qu’une chambre pour vous et que vous devrez partager les espaces communs, une colocation offre des opportunités de logements bien plus abordables.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_170',
  'Thème du débat : « Les animaux de compagnie pour les enfants, pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Offrir un animal de compagnie à un enfant présente de nombreux avantages, comme le soulignent beaucoup de psychologues. Pour des enfants qui n’ont pas des frères et/ou des sœurs, l’animal est un compagnon qui leur évitera la solitude. Grâce à lui, un enfant prendra confiance en lui et il apprendra vite qu’un animal est un être vivant qui a besoin d’attention et de respect. En sa présence, l’enfant se sentira en sécurité et pourra agir de manière autonome, sans l’aide de ses parents.

Document B :
Beaucoup d’enfants demandent, un jour ou l’autre, un animal à leurs parents, le plus souvent un chien ou un chat. Mais même si vous avez envie de faire plaisir à votre enfant, il vaut mieux réfléchir sérieusement avant d’acheter un animal domestique. L’animal devient un nouveau membre de la famille et représente un engagement sur de nombreuses années. Or, avoir un animal coûte souvent très cher, et c’est une grande responsabilité. On ne peut pas le traiter comme un jouet que l’on met à la poubelle quand l’enfant s’en désintéresse.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_171',
  'Thème du débat : « Limitation Des Voitures Dans Les Centres-Villes. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Avec des taux de pollution alarmants constatés dans plusieurs endroits dans le monde, plusieurs villes ont réussi leur pari d’interdire la circulation des voitures en zones urbaines. La capitale de Norvège, Oslo, a récemment opté pour cette solution et s’en félicite estimant que c’est une décision bénéfique pour tout le monde. Après un certain temps, les accidents diminueront, la dépendance au pétrole baissera et la qualité d’air sera meilleure !

Document B :
Beaucoup de villes se lancent dans des projets d’interdiction de voitures en zone urbaine sans mettre en place les outils et les infrastructures nécessaires pour réussir cette transition. Certes, en diminuant les voitures, on aura moins pollué, mais en contrepartie, il faut prévoir entre autres de gigantesques parkings pour garer les voitures, opter davantage pour le transport en commun (métros et Bus) et prévoir des autorisations de circulation pour certains corps de métier (comme la police, les urgentistes, les livreurs, etc.).',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_172',
  'Thème du débat : « Les Jeux Vidéo : Pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les enfants, jusqu’à l’âge de l’adolescence, jouent d’une manière régulière aux jeux vidéo et à force, ils peuvent développer des pensée négatives et des comportements agressifs. En effet, une étude récente, menée sur des enfants âgés de 9 à 18 ans jouant fréquemment aux jeux vidéo, a révélé que le fait de jouer à des jeux de violence augmente considérablement un comportement agressif. Et selon Diego Gentil, ce phénomène est inévitable quelque soit le degré de vigilance des parents!

Document B :
On parle tout le temps des effets négatifs des jeux vidéo, mais ces derniers peuvent également avoir quelques avantages pour le fonctionnement du cerveau et pour la santé d’une manière générale. si on prend, par exemple, leur rapport pour le cerveau, les jeux vidéo permettent d’améliorer plusieurs fonctions cognitives telles que l’amélioration de la concentration, de la création et de la capacité d’analyse. Ceci peut paraitre évident, dans la mesure où lorsqu’on y joue, on doit toujours trouver.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_173',
  'Thème du débat : « La gratuité des transports en commun : pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Écrivez un message à vos amis pour leur partager votre expérience de travail temporaire effectué durant les vacances d’été.

Document B :
Les transports en commun gratuits, c’est une très bonne idée. Cela permet de diminuer le nombre de voitures en ville et d’éviter les bouchons. C’est aussi une bonne mesure pour réduire la pollution et donc les risques de maladies respiratoires. Dans ma ville, il y a des transports en commun gratuits. On observe que les gens utilisent plus souvent les transports publics depuis que la gratuité est en place. Cette mesure a aussi profité aux commerçants : les gens reviennent faire leurs achats dans le centre-ville et vont moins dans les hypermarchés.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_174',
  'Thème du débat : « L’Interdiction des Voitures dans les Centres-Villes »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez été invité(e) à une fête en famille. Vous envoyez un message à vos amis pour raconter cette fête. Vous expliquez ce que vous avez le plus aimé.

Document B :
Avec des taux de pollution alarmantes constatés dans plusieurs endroits dans le monde, plusieurs villes ont réussi leur pari d’interdire la circulation de voitures en zones urbaines. La capitale de la Norvège, Oslo, a récemment opté pour cette solution et s’en félicite estimant que c’est une décision bénéfique pour tout le monde. Après un certain temps, les accidents diminueront, la dépendance au pétrole baissera et la qualité d’air sera meilleure.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_175',
  'Thème du débat : « Les Jeux Vidéo : Pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous venez d’assister au concert de votre artiste favori. Vous écrivez un article sur votre blog personnel, pour partager cette expérience et inciter vos amis et les autres à assister à son prochain concert.

Document B :
Les enfants, jusqu’à l’âge de l’adolescence, jouent d’une manière régulière aux jeux vidéo et à force, ils peuvent développer des pensée négatives et des comportements agressifs. En effet, une étude récente, menée sur des enfants âgés de 9 à 18 ans jouant fréquemment aux jeux vidéo, a révélé que le fait de jouer à des jeux de violence augmente considérablement un comportement agressif. Et selon Diego Gentil, ce phénomène est inévitable quelque soit le degré de vigilance des parents!',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_176',
  'Thème du débat : « les distributeurs de boissons dans les lycées: Pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez assisté à une fete entre voisins dans votre quartier. Dans votre blog décrivez cet événement et racontez pourquoi vous l’avez aimé.

Document B :
Je suis en faveur des distributeurs de boissons dans les lycées. Premièrement, ils offrent une commodité supplémentaire pour les élèves, notamment pour ceux qui n’ont pas le temps de passer à la cafétéria pendant les pauses. Deuxièmement, s’ils sont bien gérés, ces distributeurs peuvent offrir une gamme de boissons saines, comme de l’eau, du jus de fruits pur et des boissons aux fruits sans sucre ajouté. Ces distributeurs peuvent être une source de revenus supplémentaire pour l’école, qui peut être réinvestie dans l’amélioration des infrastructures ou des programmes scolaires.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_177',
  'Thème du débat : « Les Devoirs À La Maison »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez assisté à une soirée écologique pour protéger la planète qui avait lieu dans votre université. Racontez-là dans votre blog et expliquez pourquoi vous l’avez aimée.

Document B :
Selon des associations des parents d’élèves, les devoirs à la maison sont utiles, car ils permettent aux élèves d’apprendre à organiser leur temps de manière autonome. Pour les parents, les devoirs sont lien quotidien avec l’école. Même s’il est parfois difficile de suivre les devoirs après une journée de travail fatigant, ils apprécient ce moment partagé avec leurs enfants parce que ceux-ci sont contents que leurs parents s’intéressent à eux. C’est valorisant !',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_178',
  'Thème du débat : « La sévérité des parents envers leurs enfants : approches divergentes »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Votre direction est à la recherche d’une salle pour la fête de fin d’année, capable d’accueillir 100 invités. Rédigez un message à la direction pour leur dire que vous avez trouvé un local idéal. (Lieu, tarifs et services etc.…)

Document B :
Une étude menée par le Centre de recherche sur la parentalité de l’Université de Toronto en juin dernier a révélé que la majorité des parents adoptent des approches plus bienveillantes envers leurs enfants qu’auparavant. Cette étude a examiné un échantillon représentatif de mille familles dans différentes régions du pays et a montré que les parents encouragent une communication ouverte avec leurs enfants et adoptent des approches moins autoritaires.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_179',
  'Thème du débat : « Les Vêtements De Marque: Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez assisté à un événement intitulé « Une semaine sans voiture ». Racontez votre expérience et donnez votre impression sur cette initiative. Décrivez le déroulement de l’événement (dates, lieu, activités proposées).

Document B :
Les vêtements de marques sont très importants pour les enfants et les adolescents. C''est un moyen de s''exprimer et de se rattacher à un groupe social. Cette attirance pour les marques est très présente chez les adolescents qui se cherchent et montrent leurs personnalités. Les enfants aiment également porter des vêtements de marques avec des images des dessins animés qu''ils regardent ou des logos qu''ils apprécient.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_180',
  'Thème du débat : « Les sévérité des parents envers les enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez un vélo à vendre. Vous écrivez un courriel pour décrire votre vélo et proposer un prix. Vous lui Donnez un RDV pour essayer le vélo.

Document B :
Vous avez passé une journée à la campagne avec vos amis. À votre retour, vous écrivez un message sur votre forum pour raconter à vos amis comment cette journée s’est passée. Vous expliquez ce que vous avez aimé (activités, lieu, animaux, etc…).',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_181',
  'Thème du débat : « Faut-il faire ses courses dans des petits magasins ou dans des supermarchés ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous voulez changer la décoration de votre appartement (meubles, peinture, objets, etc.). Vous écrivez un message à un(e) ami(e). Vous lui décrivez votre projet et vous lui demandez de vous aider.

Document B :
Cours Gratuits, Concerts, Jeux.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_182',
  'Thème du débat : « Les Vols A Bas Prix »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Le supermarché est très pratique ; on y trouve une grande variété de produits, tous à portée de main. Vous pouvez garer votre voiture dans le parking et faire le tour des rayons pour acheter tout ce dont vous avez besoin : fruits, légumes, fromages, viandes, boissons… De plus, les supermarchés offrent plusieurs marques pour un même produit, tout en proposant régulièrement des promotions et des remises.

Document B :
ASSOCIATION POUR LA SAUVEGARDE DES PETITS COMMERCES',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_183',
  'Thème du débat : « Prise de position / Débat »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez participé à une brocante (achat / vente de produits d’occasion) dans votre ville. Sur votre blog personnel, racontez pourquoi vous avez aimé cette activité.

Document B :
Je fais souvent mes voyages avec des compagnies aériennes à bas prix. Les compagnies Low-cost mettent à disposition des prix inférieurs à ceux proposés par les compagnies aériennes régulières. Cela me coûte des fois moins chère que de voyager en voiture ou en train. Avec ces tarifs-là, vous en doutez qu’il y a un hic, en effet, vous n’aurez le droit à aucun service à bord (ni aliments, ni boissons). Je dirais donc, que le low-cost n’est surtout pas fait pour les vols long courrier.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_184',
  'Thème du débat : « La Lecture Pour Les Enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Avec l’avancée technologique et les produits high-tech qui envahissent de plus en plus notre quotidien, nos enfants oublient la lecture et s’intéressent davantage aux jeux vidéo, aux sports, à la musique… Contrairement à nous les adultes, dont beaucoup d’entre-nous ont lu des milliers de pages, la génération actuelle est toujours occupée par les réseaux sociaux et le gaming ou prennent du plaisir à pratiquer du sport qui attirent davantage de jeunes grâce aux stars internationales du football, du tennis, de l’athlétisme… alors avec tout ça, pourquoi devons-nous forcer les enfants à lire un bouquin ? Et comme le dit un proverbe, ‘’ le goût de la lecture ne peut pas s’imposer’’… il faut laisser l’enfant choisir ce qu’il veut lire et surtout ne pas l’obliger à lire quand il n’a pas envie.

Document B :
L’amour de la lecture se transmet de génération en génération bien que, ces dernières années, on ne trouve plus beaucoup de bouquins entre les mains des enfants, laissant la place aux smartphones et aux tablettes. En apprenant à lire régulièrement, l’enfant acquiert le langage plus aisément tout en développant sa capacité d’audition et de concentration. De plus, et pour prendre du plaisir ensemble, les parents peuvent consacrer quotidiennement 10 minutes à leurs enfants pour lire des bouquins ; une activité qui renforcera à coup sûr la complicité parent/enfant',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_185',
  'Thème du débat : « Utilisation Des Nouvelles Technologies Dans Les Écoles : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Adam : Je suis fermement convaincu que l’intégration des nouvelles technologies dans les écoles est cruciale pour préparer les élèves à un avenir numérique. Je pense que l’usage des tablettes et des ordinateurs stimule non seulement l’engagement des élèves mais enrichit également leur expérience éducative en leur offrant un accès facile à une variété de ressources, encourageant ainsi leur créativité et autonomie.

Document B :
Inas : Je suis sceptique quant à l’usage intensif des technologies dans l’enseignement. Je crois que cela peut réduire les interactions humaines essentielles et favoriser une dépendance préoccupante aux écrans. À mon avis, les méthodes d’enseignement traditionnelles et le contact direct entre enseignants et élèves restent indispensables pour un développement équilibré et complet des compétences des jeunes.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_186',
  'Thème du débat : « Les Devoirs À La Maison. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Selon des associations des parents d’élèves, les devoirs à la maison sont utiles, car ils permettent aux élèves d’apprendre à organiser leur temps de manière autonome. Pour les parents, les devoirs sont lien quotidien avec l’école. Même s’il est parfois difficile de suivre les devoirs après une journée de travail fatigant, ils apprécient ce moment partagé avec leurs enfants parce que ceux-ci sont contents que leurs parents s’intéressent à eux. C’est valorisant !

Document B :
Nous protestons depuis longtemps contre les devoirs à la maison pour plusieurs raisons. Personne ne jamais prouve leur utilité pour améliorer les résultats des élèves. Beaucoup de parents ont peu de temps pour encadrer les devoirs de leurs enfants et certains parents ne savent pas le faire. Quant aux élèves, ceux qui ont réussi les exercices en classe perdent leurs temps à faire à la maison. Ceux qui ne sont pas aidés à la maison ne réussissent toujours pas, ils sont défavorisés. C’est pourquoi nous pensons qu’il faut supprimer les devoirs à la maison.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_187',
  'Thème du débat : « Les Écoles Privées Ou Publiques ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
À la rentrée, le nombre d’élèves inscrits dans des écoles privées a augmenté en France. Le succès des établissements privés n’est pas directement lié aux bons résultats scolaires de leurs élèves. C’est la réputation de ces lieux qui explique un tel enthousiasme. Aux yeux de nombreux parents, les élèves y sont mieux encadrés, mieux surveillés et les professeurs sont plus présents. Les parents sont aussi rassurés parce que les classes sont homogènes : elles accueillent généralement des élèves de milieux sociaux favorisés. En effet, les études dans ces établissements sont payantes, ce qui n’est pas le cas dans les écoles publiques.

Document B :
Dans les collèges privés, il y a peu d’élèves de milieux sociaux défavorisés. Comme les études dans ces établissements sont payantes, certaines catégories de population en sont exclues. Ce système qui oppose écoles publiques et écoles privées ne facilite pas la mixité sociale. Ainsi, les élèves du privé ont rarement l’occasion de rencontrer d’autres jeunes issus de milieux sociaux moins favorisés qu’eux et inversement. Ce modèle scolaire reproduit les inégalités sociales et renforce le sentiment d’exclusion de certains jeunes.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_188',
  'Thème du débat : « Les Vêtements De Grande Marque »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les vêtements de marques sont très importants pour les enfants et les adolescents. C’est un moyen de s’exprimer et de se rattacher à un groupe social. Cette attirance pour les marques est très présente chez les adolescents qui se cherchent et montrent leurs personnalités. Les enfants aiment également porter des vêtements de marques avec des images des dessins animés qu’ils regardent ou des logos qu’ils apprécient.

Document B :
Les enfants grandissent très vite et les vêtements sont portés pendant une courte période. Ainsi, les vêtements deviennent rapidement trop petits.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_189',
  'Thème du débat : « Les Caméras De Surveillance à L''école : Pour ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez quitté la ville afin de vous installer à la campagne.  Sur votre blog, vous expliquez pourquoi vous avez fait ce choix et vous présentez les avantages de votre nouvelle vie.

Document B :
Dans l’école où j’enseigne à Montréal, les caméras de surveillance sont omniprésentes. Leur présence permet de dissuader les élèves de commettre des actes de violence. Les enseignants, les parents et la majorité des élèves les acceptent volontiers, car ils se sentent rassurés quant à la sécurité des enfants et que cela permet aux enseignants de travailler dans de bonnes conditions. Toutefois, certains élèves considèrent que cela porte atteinte à leur vie privée.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_190',
  'Thème du débat : « Les Caméras De Surveillance à L''école : Pour ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
–  Expliquez votre projet.

Document B :
– Décrivez le programme du voyage (activités, destination, logement, etc.).',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_191',
  'Thème du débat : « Les Caméras De Surveillance à L''école : Pour ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous répondez à Justine : 
 – Racontez un séjour d’étude que vous avez fait dans un pays étranger. 
 – Expliquez pourquoi cette expérience a été positive ou négative pour vous

Document B :
Maman d’une petite fille, Anna témoigne :',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_192',
  'Thème du débat : « Livraison Des Repas Au Bureau : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
« La réduction du temps de travail hebdomadaire n’est pas une bonne idée. La quantité de travail ne diminue pas, et le nombre de réunions non plus. On doit donc tout faire plus vite ! Selon moi, cette organisation du temps de travail est beaucoup plus fatigante. La réduction du temps de travail peut avoir des conséquences très négatives. »

Document B :
Vous avez récemment déménagé dans une nouvelle ville. Invitez votre amie à venir passer les vacances chez vous.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_193',
  'Thème du débat : « Rôle De La Télévision Dans L''éducation Des Enfants. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Karim : 
 Il faut dire que ces grands événements sportifs représentent des dépenses considérables pour l’État. Au lieu d’investir dans des compétitions coûteuses, je pense que les fonds publics devraient être prioritairement alloués à des secteurs essentiels comme la santé et l’éducation. De plus, de nombreux pays ayant accueilli ces événements se sont retrouvés endettés, sans bénéfices réels pour leurs citoyens.

Document B :
votre ami(e) veut découvrir la région dans laquelle vous habitez. Écrivez lui un message pour lui proposer des sites à visiter.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_194',
  'Thème du débat : « Cuisinier Amateur Ou Cuisinier Professionnel ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Cette pratique révèle souvent des inconvénients à cause de sa notoriété montante. Certains jours, il arrive que les responsables de livraisons peuvent être envahis par un grand nombre de livraisons à faire et cela risque de générer des perturbations liées au stress de l’attente. De même pour les employés, une trop longue heure de travail peut causer un état de fatigue si ce dernier ne quittera pas son bureau pour le repas. Dans tous les cas, il est recommandé de toujours marquer des temps de pause lors des durs labeurs.

Document B :
Écrivez un message dans le journal de votre université pour rechercher un partenaire avec qui faire du sport.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_195',
  'Thème du débat : « Vivre En Colocation »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La télévision peut également présenter certains inconvénients. Les émissions télévisées peuvent parfois véhiculer des stéréotypes, des préjugés et des valeurs discutables. De plus, le temps passé devant la télévision peut réduire le temps consacré à d’autres activités plus enrichissantes, telles que la lecture, les interactions sociales ou la pratique d’un sport. Il est important de faire preuve de discernement et de réguler l’exposition à la télévision, en particulier pour les enfants, afin de préserver un équilibre sain entre les différentes formes d’apprentissage et de divertissement.

Document B :
Vous avez invité votre ami Cédric à votre mariage au Château de Chombony et il vous a répondu qu’il ne connait pas ce château.  Décrivez à votre ami (lieu, localisation, transports, etc.).',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_196',
  'Thème du débat : « Le Travail : Favorable ou Défavorable ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Il parle des cuisiniers qui ont appris le métier de cuisiniers sur internet et qui ont le buzz sur les réseaux sociaux il raconte aussi l’histoire d’une amatrice qui est devenue professionnelle et qui a rédigé plusieurs livres sur la cuisine pour les amateurs de cuisine à la maison.

Document B :
Votre ami Mehdi vient de d’emménager dans votre ville et cherche des renseignements sur les moyens de transports. Écrivez un message en lui donnant les informations nécessaires (types de transport, abonnement, tarif, etc.)',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_197',
  'Thème du débat : « Les Relations Amicales Au Travail »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La colocation peut cependant présenter des défis. Les différences de personnalité et de mode de vie entre les colocataires peuvent entraîner des tensions. La gestion des responsabilités et des tâches ménagères peut également être source de conflits. De plus, la colocation peut limiter l’intimité et l’espace personnel. Il est important d’établir une communication ouverte et respectueuse, ainsi que des règles de vie commune, pour favoriser une cohabitation harmonieuse.

Document B :
Vous voulez partir en week-end avec vos amis le mois prochain. Vous leur écrivez un message pour décrire votre projet (lieu, transport, activités, etc.).',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_198',
  'Thème du débat : « L''interdiction des voitures en ville. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Le travail est au centre de notre vie. Dès l’enfance, on entend souvent la question: «Qu’est-ce que tu veux faire quand tu seras grand ? ». Le travail devrait être synonyme de réussite et de satisfaction, mais il est trop souvent synonyme de fatigue et d’emprisonnement. Aujourd’hui, beaucoup pensent que l’on ne passe pas assez de temps avec sa famille, ses amis. Il est urgent de revoir la place occupée par le travail dans notre société. Certains pensent que travailler moins permettrait d’avoir plus de temps libre pour mieux vivre.

Document B :
Certaines personnes ont décidé d’arrêter de travailler pour changer de mode de vie. Pourtant, aujourd’hui, travailler, c’est exister La question : «Qu’est-ce que tu fais dans la vie ?» revient souvent lors d’une première rencontre. Elle prouve que l’emploi fait partie de notre identité. D’après le spécialiste Jean-Daniel Remond, la vie en entreprise est très importante. Les contacts quotidiens, les réseaux, les amitiés, l’impression d’être utile, mais aussi les difficultés, tout cela contribue à construire notre personnalité et notre identité.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_199',
  'Thème du débat : « l''utilisation du plastique, pour ou contre »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous êtes allés voir un spectacle (film, pièce de théâtre, concert, etc.) avec des amis. Vous l’avez aimé. Sur votre blog, vous racontez votre soirée et vous expliquez pourquoi vous avez aimé le spectacle.

Document B :
Les amitiés entre collègues au travail peuvent être extrêmement bénéfiques. Elles favorisent un climat de travail agréable et une ambiance positive au sein de l’équipe. Avoir des amis parmi ses collègues permet de renforcer les liens professionnels et de créer un sentiment de camaraderie. Cela peut contribuer à une meilleure communication, une collaboration plus étroite et une résolution plus efficace des problèmes. De plus, partager des moments de convivialité en dehors du travail, comme des déjeuners ou des activités après le bureau peut renforcer les liens et créer une dynamique de groupe solide.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_200',
  'Thème du débat : « Le livre papier ou le livre numérique? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Écrivez un message à vos amis pour leur raconter à propos d''une fête à laquelle vous avez assisté en famille.

Document B :
Le dernier exemple vient d’Oslo, la capitale norvégienne. Une responsable du projet annonce : « Ce sera mieux pour les piétons, les cyclistes, les commerces. Mieux pour tout le monde ». Moins de voitures, c’est la reconquête de la ville par ses habitants. Les bénéfices pour la qualité de l’air et pour l’économie locale seront garantis.',
  NULL,
  true
);

INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
(
  'expression_ecrite',
  3,
  'EE_T3_201',
  'Thème du débat : « Habitudes alimentaires pour ou contre? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous répondez à votre amie Barbara. Vous décrivez le lieu (parc, jardin, terrasse, etc.)

Document B :
Vous avez visité un nouveau pays pendant vos vacances. Sur un site internes, vous racontez votre expérience et vous donnez votre opinion sur ce pays.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_202',
  'Thème du débat : « Prise de position / Débat »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Je vais bientôt vivre dans ton quartier. Je cherche un endroit sympathique pour faire mes courses. Est-ce que tu connais un marché intéressant ?

Document B :
Merci d’avance et à bientôt !',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_203',
  'Thème du débat : « Prise de position / Débat »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Depuis plusieurs années maintenant, de nombreux lecteurs ont décidé de remplacer la bibliothèque traditionnelle par des livres numériques. Selon eux, l’avantage est avant tout économique. D’une part, le livre numérique permet d’économiser du papier, d’autre part la version numérique d’un livre est généralement moins chère que la version papier. Les livres numériques ont un autre avantage : ils permettent une ouverture sur le monde pour les personnes en situation de handicap. Certaines options, comme la possibilité d’augmenter la taille des lettres, facilitent la lecture pour les personnes malvoyantes.

Document B :
Le livre numérique remplacera-t-il le livre papier ? « Non », répondront la plupart des lecteurs. Le livre papier est un beau support. Quel plaisir de le prêter aux gens qu’on aime ou de l’offrir en glissant un petit mot dedans ! Le livre papier a une histoire, l’odeur du neuf ou de l’ancien… Il transmet beaucoup d’émotions alors que le livre numérique à un côté un peu impersonnel. De plus, les livres numériques demandent de posséder un minimum de connaissances en informatique, ce qui peut être une difficulté pour certaines personnes.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_204',
  'Thème du débat : « Les parcs zoologiques : Pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
www.manger-international.com 
 Ce mois-ci, nous nous intéressons aux habitudes alimentaires dans le 
 monde. Racontez-nous comment mangent les habitants de votre pays ! 
 Les 10 premiers témoignages seront publiés sur notre site !

Document B :
Vous avez lu cette annonce Vous écrivez un article pour les lecteurs du site www.manger-international.com Vous expliquez comment mangent les habitants de votre pays et vous indiquez quelles habitudes 
 vous plaisent ou vous déplaisent, et pourquoi',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_205',
  'Thème du débat : « Jeux vidéo. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Tout quitter pour partir en voyage pendant un an: bonne ou mauvaise idée ?

Document B :
Répondez sur notre site Internet : “voyage.internaute.fr”. Vous écrivez un message sur ce site internet, vous répondez à la question posée en prenant des exemples de votre vie personnelle.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_206',
  'Thème du débat : « Le Travail : Favorable ou Défavorable ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Je fais souvent mes voyages avec des compagnies aériennes à bas prix. Les compagnies Low-cost mettent à disposition des prix inférieurs à ceux proposés par les compagnies aériennes régulières. Cela me coûte des fois moins chère que de voyager en voiture ou en train. Avec ces tarifs-là, vous en doutez qu’il y a un hic, en effet, vous n’aurez le droit à aucun service à bord (ni aliments, ni boissons). Je dirais donc, que le low-cost n’est surtout pas fait pour les vols long courrier.

Document B :
Récemment, j’ai pris la décision de ne plus voyager avec les compagnies aériennes à bas prix. En effet, j’ai longuement réfléchi afin de prendre ma décision, mais ce choix était évident : des sièges inconfortables, des conditions de travail pénibles et surtout des avions vétustes qui remettent en cause la sécurité ! Dès lors, pour certains voyages, je vais opter pour la voiture ou même le train, ce dernier permet même de découvrir de jolis paysages. Quant aux longs trajets, vaut mieux prendre un vol en compagnie régulière.ç',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_207',
  'Thème du débat : « vols à bas prix »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
loDe plus en plus d’écoles décident de mettre en place un menu sans viande dans les cantines, au moins deux fois par semaine. Certaines études ont montré que les enfants consomment trop de protéines animales. C’est donc une question de santé : les écoles ont choisi de remplacer la viande par d’autres produits (soja, céréales, légumes), moins gras et utiles à la croissance des enfants. Ces menus sans viandes à la cantine reviennent moins cher aux familles. Cette idée plaît beaucoup aux parents comme aux enfants.

Document B :
La décision de supprimer la viande dans les cantines ne plaît pas à tout le monde. En effet, c’est un produit cher : la cantine est le seul endroit où les enfants de familles en difficulté peuvent manger. Les producteurs locaux de viande sont également mécontents : une partie de leur production est réservée aux cantines, il s’agit donc d’une perte financière. Enfin, beaucoup d’enfants interrogés déclarent tout de même préférer les steaks de bœuf aux steaks de soja qui, selon eux, ont peu de goût.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_208',
  'Thème du débat : « vols à bas prix »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Je suis vraiment intéressé à l’idée de voyager et de découvrir un autre pays. Peux-tu me parler un peu de ton pays et de sa culture ?

Document B :
Écrivez un message à votre ami Marc, qui veut voyager et découvrir un autre pays, pour lui parler de votre pays et de sa culture (lieux, sites touristiques, monuments, etc). »',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_209',
  'Thème du débat : « deux opinions sur les menus sans viande aux cantines scolaires. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Tout quitter pour partir en voyage pendant un an: bonne ou mauvaise idée ?

Document B :
Répondez sur notre site Internet : “voyage.internaute.fr”. Vous écrivez un message sur ce site internet, vous répondez à la question posée en prenant des exemples de votre vie personnelle.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_210',
  'Thème du débat : « limitation des voitures dans les centres-villes (pour ou contre) »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Opinion 1 : Alexandre, un conseiller d’orientation

Document B :
“Je suis fermement pour le travail des jeunes pendant les vacances. C’est une excellente occasion d’acquérir des compétences pratiques, d’apprendre à travailler en équipe et de découvrir différentes industries. Les jeunes peuvent gagner de l’argent qu’ils peuvent économiser pour l’avenir ou utiliser pour financer des activités ou des loisirs. De plus, le fait d’avoir une expérience de travail sur leur CV peut leur donner un avantage lorsqu’ils postulent pour des emplois ou des stages à l’avenir. Les vacances d’été sont longues et il y a amplement de temps pour se reposer et travailler.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_211',
  'Thème du débat : « restauration rapide, pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Parc de loisirs : “J’ai hâte de passer la journée avec toi demain. S’il te plaît, dis-moi, quelle activité nous pourrons faire ?”

Document B :
Répondez à votre ami pour lui décrire la sortie (horaires,',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_212',
  'Thème du débat : « deux avis sur l''uniforme scolaire »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Jean qui vit à la compagne favorise l’achat des produits alimentaires directement à la ferme pour la bonne qualité quitte à payer un peu plus cher.

Document B :
Camille qui vit dans la ville préfère faire ses courses au supermarché pour la variété qu’il propose et pour les prix abordables.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_213',
  'Thème du débat : « deux avis sur les jeux vidéos »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les raisons qui poussent les parents à opter pour la scolarisation à domicile sont nombreuses. Elle donne la possibilité d’adopter une pédagogie plus individualisée. On peut passer plus de temps sur les points sur lesquels l’enfant bute ou lui proposer, à l’occasion, des jeux éducatifs. L’enfant gère son apprentissage à son rythme, il creuse les sujets qui le passionnent et ne subit pas la pression des autres élèves qui peuvent avancer plus au moins vite que lui. Autre avantage de l’instruction en famille, une évolution différente. Avec l’école à la maison, pas de notes qui peuvent parfois être décourageantes, mais un contrôle continu des connaissances, pas de stress dû aux évaluations et aux devoirs.

Document B :
Le choix de la scolarisation à domicile représente un véritable défi et donc, quelques inconvénients à prendre en compte avant de se lancer. La scolarisation à domicile nécessite beaucoup de temps, une bonne organisation et elle a aussi un coût. Tout le matériel, les livres, les manuels, et les sorties sont à la charge des familles, et l’un des deux parents est souvent amené à mettre entre parenthèses son emploi. Au total, l’école à domicile coûte généralement plus cher qu’une scolarisation dans le public. De plus, l’enfant ne côtoie pas de camarades au quotidien, car l’école à domicile ne permet pas à l’enfant d’entrer en interaction avec d’autres enfants comme il le ferait dans un cadre scolaire classique.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_214',
  'Thème du débat : « Égalité Homme/Femme en Milieu de Travail. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Quand on parle de vélo, on pense systématiquement à deux choses: sport et loisir. On oublie souvent que c’est avant tout un mode de déplacement personnel et professionnel. En ville, c’est un moyen de transport rapide et déstressant puisqu’il permet d’éviter les interminables embouteillages aux heures de pointe. Se rendre au travail tout en faisant du sport, histoire de joindre l’utile à l’agréable.

Document B :
Avec tous les accidents de la route observés annuellement, sortir son vélo pour se déplacer avec en ville peut être très dangereux. En effet, avec la densité importante de véhicules, le non-respect du Code de la route et le manque de pistes cyclables, pratiquer du vélo en zone urbaine présente de vrais risques d’accident. De plus, faire du vélo de nos jours, c’est s’exposer à des gaz d’échappement toxiques et nocifs pour la santé humaine (notamment le monoxyde de carbone…).',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_215',
  'Thème du débat : « Le travail des étudiants pendant les vacances: Pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Dans nos jours, les villes grossissent toujours plus. Malheureusement, ce phénomène a un impact fort sur l’environnement. Car plus une ville grossisse, plus elle a des effets négatifs sur la nature et donc, ensuite, sur l’homme. L’effet négatif le plus visible est la déforestation, qui augmente les végétaux qui retiennent le carbone. Donc, quand on les supprime pour construire des bâtiments ou des rues, on supprime de espaces verts capables de retenir des millions de tonnes de carbone.

Document B :
Plus, de la moitié de l’humanité vit en ville (huit habitants sur dix dans les pays riches) la vie urbaine est donc le principal enjeu écologique. On entend souvent dire que l’organisation actuelle des villes n’est pas écologique. Et que le grossissement des villes ne fait qu’augmenter le problème. Pourtant, il faut se méfier des apparences : les villes ne sont pas toujours aussi antiécologique qu’on l’imagine. Par exemple, la consommation d’énergie d’un citadin est moins importante que celle d’un habitant de la campagne.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_216',
  'Thème du débat : « L''école à domicile, pour ou contre? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les objets connectés facilitent notre vie quotidienne. Ce sont des objets ou des équipements pilotés à distance à l’aide d’un téléphone portable ou par Internet, comme le système de chauffage ou la fermeture des portes. De plus, avec une montre ou un bracelet connecté, toutes nos activités peuvent être analysées. Un logiciel va mesurer le nombre de nos pas pour nous inciter à faire davantage d’exercice. Un domaine où l’on comprend mieux leur utilité est celui de la surveillance de la santé. Certains objets agissent comme un carnet de santé, toujours prêts à vous rappeler un rendez-vous chez le médecin ou des médicaments à prendre.

Document B :
Il y aurait 50 milliards d’objets connectés dans le monde : l’alarme, le téléviseur, la caméra de surveillance, les volets, le détecteur de fumée. etc. Face à cette évolution, la question de la sécurité se pose. En effet, un pirate informatique peut prendre le contrôle d’un objet connecté en quelques minutes. Ou encore, un cambrioleur pourrait vérifier grâce aux caméras de surveillance connectées d’une habitation que les occupants sont absents. Il est aussi possible d’entrer dans le système connecté d’une voiture, et d’en prendre les commandes à distance.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_217',
  'Thème du débat : « Vivre chez ses parents, pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les inconvénients manque de liberté, Vivre seuls leur permet d’être indépendant, les adolescents qui vivent Avec leurs parents s’ennuient car leurs parents décident à leur place et se sont toujours de pondant des parents […] un avis d’un certain monsieur qui à 25 et il a perdu son job, donc il était dans l’obligation de rentrer vivre avec ces parents, et maintenant il a perdu son espace d’intimitée … contre la vie des jeunes avec leurs parent, un témoignage d’un jeune qui considère revenir chez ces parents c’est avoir revenir en arrières.

Document B :
Ecrivez un message à vos amis pour les inviter à votre anniversaire et leur raconter comment va se dérouler votre fête.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_218',
  'Thème du débat : « Les nouvelles technologies pour les enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les nouvelles technologies encouragent les enfants à être sédentaires. C’est une préoccupation majeure pour les parents. Cela ne mène à aucun jeu libre créatif, à aucune interaction sociale face à face, conduisant à aucun effort physique! Pourquoi ne pas essayer certaines de ces activités amusantes pour encourager vos enfants à ranger leurs appareils ?

Document B :
Votre ami veut se mettre au sport. Vous lui envoyez un message pour lui conseiller une salle de sport situé dans votre quartier (localisation, prix, type d’activités, etc…)',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_219',
  'Thème du débat : « La lecture pour les enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
L’amour de la lecture se transmet de génération en génération bien que, ces dernières années, on ne trouve plus beaucoup de bouquins entre les mains des enfants, laissant la place aux smartphones et aux tablettes. En apprenant à lire régulièrement, l’enfant acquiert le langage plus aisément tout en développant sa capacité d’audition et de concentration. De plus, et pour prendre du plaisir ensemble, les parents peuvent consacrer quotidiennement 10 minutes à leurs enfants pour lire des bouquins ; une activité qui renforcera à coup sûr la complicité parent/enfant.

Document B :
Vous faites du sport dans un club. Vous venez de remporter une compétition Vous écrivez un courriel à vos amis pour leur raconter cet évènement sportif et annoncer votre réussite sportive',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_220',
  'Thème du débat : « Le grossissement des villes »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Plus de la moitié de l’humanité vit en ville (huit habitants sur dix dans les pays riches) la vie urbaine est donc le principal enjeu écologique.On entend souvent dire que l’organisation actuelle des villes n’est pas écologique, et que le grossissement des villes ne fait qu’augmenter le problème. Pourtant, il faut se méfier des apparences : les villes ne sont pas toujours aussi antiécologique qu’on l’imagine. Par exemple, la consommation d’énergie d’un citadin est moins importante que celle d’un habitant de la campagne.

Document B :
Les professeurs de l''école de votre quartier souhaitent présenter différents métiers aux élèves. Vous voulez participer à ce projet pour parler de votre expérience. Vous leur écrivez. Vous décrivez votre profession (activités, collègues, etc.). Vous expliquez pourquoi vous trouvez votre métier intéressant.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_221',
  'Thème du débat : « Louer son appartement à des inconnus, est-ce une bonne idée ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Je cherche un vélo en bon état et bon marché. Contactez-moi par courriel

Document B :
Vous avez un vélo à vendre.  Vous écrivez un courriel pour décrire votre vélo et proposer un prix. Vous lui donnez un rendez-vous pour essayer le vélo.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_222',
  'Thème du débat : « L’interdiction des Voitures dans les Centres-Villes »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Répondez au courriel de votre ami Lucas pour lui donner des informations sur les nouveaux locaux de votre entreprise (lieu, disposition des pièces, équipements, etc.).

Document B :
Vous avez assisté à un événement intitulé “Une semaine sans voiture”. Racontez votre expérience et donnez votre impression sur cette initiative. Décrivez le déroulement de l’événement (dates, lieu, activités proposées).',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_223',
  'Thème du débat : « Les Jeux Vidéo : Pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Mais il y a aussi le fait que les enfants usent assez rapidement les vêtements en jouant à l’extérieur avec les copains, en s’amusant dans l’herbe ou à l’air de jeux. Les habits sont très vite sales ou troués.

Document B :
Vous avez publié une annonce pour la location de votre appartement. Rédigez un courriel à une personne intéressée en lui fournissant des informations sur l’appartement ainsi que sur le quartier.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_224',
  'Thème du débat : « Faut-il faire ses courses dans des petits magasins ou dans des supermarchés ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez participé à cet évènement. Vous écrivez à vos amis pour raconter votre expérience et vous donnez votre opinion sur cette journée.

Document B :
Le supermarché est très pratique ; on y trouve une grande variété de produits, tous à portée de main. Vous pouvez garer votre voiture dans le parking et faire le tour des rayons pour acheter tout ce dont vous avez besoin : fruits, légumes, fromages, viandes, boissons… De plus, les supermarchés offrent plusieurs marques pour un même produit, tout en proposant régulièrement des promotions et des remises.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_225',
  'Thème du débat : « Les sévérité des parents envers les enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
« Je cherche un vélo en bon état et bon marché. Contactez- 
 moi par courriel :  [email&#160;protected]

Document B :
Vous avez un vélo à vendre. Vous écrivez un courriel pour 
 décrire votre vélo et proposer un prix. Vous lui Donnez un RDV 
 pour essayer le vélo.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_226',
  'Thème du débat : « Les Vêtements de Grandes Marques »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les parents ont parfois peur d’être trop sévères avec leurs enfants. Ils craignent, qu’à cause d’un excès d’autorité, leurs enfants ne s’épanouissent pas et manquent plus tard de personnalité. Même si les parents acceptent, par amour, tout ce dont leurs enfants demandent, cela pourrait avoir des effets négatifs lorsqu’ils passent à l’âge adulte. En effet, pour vivre en communauté, il y a certaines règles à respecter.

Document B :
Répondez au courriel de votre ami Lucas pour lui donner des informations sur les nouveaux locaux de votre entreprise  (lieu, disposition des pièces, équipements, etc.).',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_227',
  'Thème du débat : « Les animaux de compagnie pour les enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les enfants grandissent très vite et les vêtements sont portés pendant une courte période. Ainsi, les vêtements deviennent rapidement trop petits.

Document B :
Mais il y a aussi le fait que les enfants usent assez rapidement les vêtements en jouant à l’extérieur avec les copains, en s’amusant dans l’herbe ou à l’air de jeux. Les habits sont très vite sales ou troués.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_228',
  'Thème du débat : « La réduction du temps de travail »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous souhaitez assister à un festival de cinéma dans votre ville. Vous écrivez un message à votre ami(e) pour lui proposer de venir avec vous. Vous lui donnez toutes les informations nécessaires sur févènement (films, dates et horaires, tarifs, etc.).

Document B :
Vous avez accueilli un étudiant étranger pendant une semaine chez vous. Sur votre blog, vous écrivez un article pour raconter cette semaine. Vous expliquez pourquoi vous avez aimé cette expérience.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_229',
  'Thème du débat : « Faire Ses Courses Alimentaires Chez Les Producteurs Locaux Ou Au Supermarché »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Camille qui vit dans la ville préfère faire ses courses au supermarché pour la variété qu’il propose et pour les prix abordables.

Document B :
Vous avez passé un week-end à la campagne. Écrivez un message à votre ami(e) pour lui décrire ce qui s’est passé.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_230',
  'Thème du débat : « Utilisation Des Nouvelles Technologies Dans Les Écoles : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Sara : Je suis sceptique quant à l’usage intensif des technologies dans l’enseignement. Je crois que cela peut réduire les interactions humaines essentielles et favoriser une dépendance préoccupante aux écrans. À mon avis, les méthodes d’enseignement traditionnelles et le contact direct entre enseignants et élèves restent indispensables pour un développement équilibré et complet des compétences des jeunes.

Document B :
Rédigez un message pour inviter votre ami à passer ses vacances dans votre ville.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_231',
  'Thème du débat : « La Chasse Aux Animaux : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
“Les gens chassent pour différentes raisons : la subsistance, le commerce, la conversation et l’aménagement de la faune, la protection de la propriété, l’exercice, le loisir et le prestige.”

Document B :
David, Journaliste de la FRM.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_232',
  'Thème du débat : « L’art Urbain : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Grâce à l’art, la curiosité des citadins est attisée dans l’espace urbain. Que ce soit par une peinture ou un spectacle de rue, l’atmosphère éphémère ainsi créée offre une interaction entre des artistes peu connus et un public hétéroclite, parfois peu habitué à côtoyer cette forme d’art. Les villes d’aujourd’hui n’ont plus la même vocation que celles d’hier. Plus qu’un lieu de résidence, la ville se réinvente, s’enrichit de la diversité de sa population, s’agence différemment et s’ouvre sur le monde. Les espaces verts se créent et les murs se parent de couleurs grâce au street art. Cela débouche sur des lieux où la qualité de vie est privilégiée, tout en respectant la nature et l’environnement.

Document B :
Mais à une plus large échelle, cela n’est pas aussi évident. Les graffitis peuvent être perçus comme une dégradation de la communauté, une pollution visuelle ou une preuve de la rupture sociale. On les considère comme du vandalisme qui défigure les biens publics. Le débat sur les avantages et les inconvénients des graffitis fait rage parmi les artistes, les législateurs et les membres de la communauté.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_233',
  'Thème du débat : « Les Objets Connectés : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous participez à ce concours. Vous expliquez pourquoi vous avez choisi cet(te) artiste et vous racontez sa vie.

Document B :
Les objets connectés facilitent notre vie quotidienne. Ce sont des objets ou des équipements pilotés à distance à l’aide d’un téléphone portable ou par Internet, comme le système de chauffage ou la fermeture des portes. De plus, avec une montre ou un bracelet connecté, toutes nos activités peuvent être analysées. Un logiciel va mesurer le nombre de nos pas pour nous inciter à faire davantage d’exercice. Un domaine où l’on comprend mieux leur utilité est celui de la surveillance de la santé. Certains objets agissent comme un carnet de santé, toujours prêts à vous rappeler un rendez-vous chez le médecin ou des médicaments à prendre.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_234',
  'Thème du débat : « La Restauration Rapide »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous faites une réclamation par rapport aux mauvaises prestations d’une agence de voyages suite à un voyage mal organisé.  Exprimez votre mécontentement.

Document B :
Les restaurants rapides proposent des plats équilibrés et variés, et ils respectent les normes d’hygiène et les variétés de produits qui sont bons, et c’est le client qui compose son menu, donc il en est responsable.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_235',
  'Thème du débat : « La Gratuité Des Musées : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous venez de commencer une nouvelle activité de loisir (sport, danse, etc.).  Écrivez un article sur votre blog pour parler de cette expérience.

Document B :
La gratuité des musées peut entraîner une surfréquentation, ce qui nuit à la qualité de l’expérience des visiteurs. De plus, cela peut réduire les ressources financières des musées, affectant ainsi leur entretien et la préservation des œuvres. Un tarif réduit serait une meilleure solution pour rendre la culture accessible tout en soutenant les musées.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_236',
  'Thème du débat : « La Sieste Au Travail : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Écrivez un article sur votre blog pour raconter pourquoi vous avez décidé de changer votre alimentation (vos habitudes alimentaires).

Document B :
D’après le site síestepourtous.com,',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_237',
  'Thème du débat : « Livraison Des Repas Au Bureau : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
employés lors de la sieste (prévention des situations de harcèlement), l’égalité de traitement entre salariés, l’établissement d’une charte gérant re salariés, etc.

Document B :
Votre ami(e) veut découvrir la région dans laquelle vous habitez. Écrivez lui un message pour lui proposer des sites à visiter.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_238',
  'Thème du débat : « Les Jeux Vidéo, Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La télévision peut également présenter certains inconvénients. Les émissions télévisées peuvent parfois véhiculer des stéréotypes, des préjugés et des valeurs discutables. De plus, le temps passé devant la télévision peut réduire le temps consacré à d’autres activités plus enrichissantes, telles que la lecture, les interactions sociales ou la pratique d’un sport. Il est important de faire preuve de discernement et de réguler l’exposition à la télévision, en particulier pour les enfants, afin de préserver un équilibre sain entre les différentes formes d’apprentissage et de divertissement.

Document B :
Vous partez en vacances avec vos amis, vous avez trouvé un hôtel.  Vous écrivez un message à vos amis pour décrire cet hôtel (localisation, prix, équipements, etc.) et vous leur proposez de réserver cet hôtel.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_239',
  'Thème du débat : « Les Relations Amicales Au Travail : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Pendant trois ans, des enfants âgés de 8 à 17 ans ont participé à une étude sur les jeux vidéo. Les résultats de cette étude montrent que les enfants qui jouent beaucoup aux jeux vidéo sont plus violents, plus nerveux et plus stressés que ceux qui ne jouent pas ou peu. Ceux qui jouent beaucoup ont également moins de bons résultats à l’école. Il est donc conseillé aux parents d’être vigilants et de limiter l’usage de ces jeux par leurs enfants.

Document B :
“Bonjour, ça y est, j’ai obtenu mon visa pour le Canada. Je vais arriver le 3 mars. Est-ce que tu pourras m’aider à trouver un hôtel pour la première semaine ? Merci d’avance pour ton aide.”',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_240',
  'Thème du débat : « L’Utilisation Du Plastique, Pour Ou Contre »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les amitiés entre collègues au travail peuvent être extrêmement bénéfiques. Elles favorisent un climat de travail agréable et une ambiance positive au sein de l’équipe. Avoir des amis parmi ses collègues permet de renforcer les liens professionnels et de créer un sentiment de camaraderie. Cela peut contribuer à une meilleure communication, une collaboration plus étroite et une résolution plus efficace des problèmes. De plus, partager des moments de convivialité en dehors du travail, comme des déjeuners ou des activités après le bureau peut renforcer les liens et créer une dynamique de groupe solide.

Document B :
Il est important de trouver un équilibre entre amitié et professionnalisme au travail. Les amitiés excessivement proches peuvent parfois créer des tensions ou des conflits lorsque des décisions professionnelles doivent être prises. De plus, les amitiés exclusives entre certains collègues peuvent exclure les autres membres de l’équipe, ce qui peut nuire à la cohésion et à la collaboration. Il est essentiel de maintenir des limites claires et de veiller à ce que les amitiés ne compromettent pas le professionnalisme, la hiérarchie ou la productivité au sein de l’organisation.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_241',
  'Thème du débat : « Les Habitudes Alimentaires »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez visité un nouveau pays pendant vos vacances.  Sur un site internet, racontez votre expérience et donnez votre opinion sur ce pays.

Document B :
Franck soutient l’utilisation limitée du plastique, soulignant son importance dans de nombreux secteurs, notamment les secteurs médical et alimentaire. Pour lui, le plastique est vital pour la conservation des aliments et la stérilisation des équipements médicaux. Il prône une utilisation responsable et le recyclage, mais reconnaît que certains usages du plastique sont indispensables pour la société moderne.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_242',
  'Thème du débat : « Cours de langue à distance »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Deux amis souhaitent passer deux semaines de congé chez vous.  Écrivez-leur un message pour leur proposer des lieux à visiter (endroits historiques, restaurants, etc.).

Document B :
De nos jours, les journées passent très vite car nous sommes tout le temps pris par un rythme de vie effréné : travail, enfants, loisirs… Dès lors, beaucoup d’entre nous préfèrent et favorisent des habitudes alimentaires basées essentiellement sur des repas tout faits à emporter ou à consommer sur place. Prenons l’exemple d’Annette, une jeune femme de 28 ans qui se consacre énormément à son travail et qui aime dîner au restaurant tout en passant de bons moments avec ses amis. Cela lui permet de manger sainement sans avoir à passer des heures dans la cuisine après une rude journée de travail. Ce mode de vie lui convient en tant que célibataire, lui permettant de découvrir de nouveaux restaurants bien notés, de faire de nouvelles connaissances, et d’éviter de longues soirées seule devant sa télévision. Et ceci est vrai même pour les plus jeunes.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_243',
  'Thème du débat : « Le livre papier ou le livre numérique? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous répondez à votre ami Ali. Dans votre message, vous décrivez votre nouveau travail (lieu, collègues, etc.) et vous donnez vos impressions.

Document B :
Vivre avec les personnes âgées, est-ce facile ?',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_244',
  'Thème du débat : « L’Éducation des Enfants. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Merci d’avance et à bientôt !

Document B :
Vous répondez à votre ami Bernard. Dans votre message, vous décrivez un marché de votre quartier que vous aimez bien (lieu, horaires, produits, etc.)',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_245',
  'Thème du débat : « Menus Sans Viande à La Cantine Scolaire. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Le livre numérique remplacera-t-il le livre papier ? « Non », répondront la plupart des lecteurs. Le livre papier est un beau support. Quel plaisir de le prêter aux gens qu’on aime ou de l’offrir en glissant un petit mot dedans ! Le livre papier a une histoire, l’odeur du neuf ou de l’ancien… Il transmet beaucoup d’émotions alors que le livre numérique à un côté un peu impersonnel. De plus, les livres numériques demandent de posséder un minimum de connaissances en informatique, ce qui peut être une difficulté pour certaines personnes.

Document B :
Votre ami va fêter son anniversaire.  Écrivez un message à vos amis pour lui acheter un cadeau commun.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_246',
  'Thème du débat : « La Gratuité Des Musées : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez assisté à un événement sportif.  Racontez votre expérience sur le journal de votre site web (environnement, préparatifs, supporters, etc).

Document B :
De plus en plus d’écoles décident de mettre en place un menu sans viande dans les cantines, au moins deux fois par semaine. Certaines études ont montré que les enfants consomment trop de protéines animales. C’est donc une question de santé : les écoles ont choisi de remplacer la viande par d’autres produits (soja, céréales, légumes), moins gras et utiles à la croissance des enfants. Ces menus sans viandes à la cantine reviennent moins cher aux familles. Cette idée plaît beaucoup aux parents comme aux enfants.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_247',
  'Thème du débat : « Les Caméras De Surveillance A L’école : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La gratuité des musées est une excellente initiative. Cela rend la culture accessible à tous, indépendamment de leur situation financière. J’ai pu visiter plusieurs musées gratuitement, ce qui m’a permis d’enrichir mes connaissances sans me soucier du coût. Pour moi, la gratuité des musées contribue à l’éducation du public et au partage du patrimoine culturel.

Document B :
Vous avez quitté la ville afin de vous installer à la campagne.  Sur votre blog, vous expliquez pourquoi vous avez fait ce choix et vous présentez les avantages de votre nouvelle vie.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_248',
  'Thème du débat : « Cuisinier Amateur Ou Cuisinier Professionnel ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez invité votre ami Cédric à votre mariage au Château de Chombony et il vous a répondu qu’il ne connait pas ce château.  Décrivez à votre ami (lieu, localisation, transports, etc.).

Document B :
Les amateurs ont fait des recettes réussies, mais ils manquent toujours des compétences et des technique, c’est pourquoi la formations et l’expérience sont nécessaires pour être un vrai cuisinier.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_249',
  'Thème du débat : « L’utilisation Des Distributeurs Automatiques Au Sein Des Établissements Scolaires, Pour ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
“Je suis contre l’installation de distributeurs de boissons dans les lycées. Ma principale préoccupation est liée à la santé des élèves. Malheureusement, beaucoup de ces distributeurs sont remplis de boissons sucrées et de sodas qui contribuent à l’obésité infantile et à d’autres problèmes de santé comme le diabète. Même les jus de fruits, qui peuvent sembler sains, contiennent souvent beaucoup de sucre. Les écoles devraient être des lieux qui encouragent des habitudes alimentaires saines et je crains que la présence de ces distributeurs n’encourage une consommation excessive de boissons sucrées.”

Document B :
Opinion 1 : Alexandre, un conseiller d’orientation',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_250',
  'Thème du débat : « Le travail des étudiants pendant les vacances: Pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
“Je suis contre l’idée que les jeunes doivent travailler pendant leurs vacances. Les adolescents sont déjà sous une énorme pression pendant l’année scolaire avec les études, les examens et les activités parascolaires. Les vacances doivent être une période pour eux de se détendre, de se décompresser et de poursuivre des intérêts personnels. Les forcer à travailler pourrait contribuer au stress et à l’épuisement. Il est également important pour les jeunes de disposer de temps non structuré pour explorer leur créativité, passer du temps avec leurs amis et leur famille, et tout simplement être des enfants. Le travail peut attendre.”

Document B :
La vie en colocation offre de nombreux avantages. Partager un logement avec d’autres personnes permet de réduire les dépenses, que ce soit le loyer, les factures ou les frais généraux. De plus, cela favorise les interactions sociales et les échanges culturels. Vivre avec des colocataires permet de rencontrer des individus de différents horizons, de nouer des amitiés et de partager des expériences enrichissantes.',
  NULL,
  true
);

INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
(
  'expression_ecrite',
  3,
  'EE_T3_251',
  'Thème du débat : « Vivre En Colocation : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les achats en ligne ont des avantages comme gagner de temps consommateurs les et de trouvent l’argent. les facilement, disponibilité 24/24, produits provenant de tout le monde etc.

Document B :
Les magazines nous donne la possibilité d’avoir un contact humain et relation avec les vendeurs + possibilité de voir et de toucher ce qu’on veut … les consommateurs favorisent l’achat traditionnel, visiter des magasins le permette d’échanger des achats insatisfaisants et de se se communiquer avec les vendeurs.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_252',
  'Thème du débat : « Les Achats en Ligne. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous écrivez un message sur ce site internet Vous répondez à la question posée en prenant des exemples de votre vie personnelle.

Document B :
Le travail est au centre de notre vie. Dès l’enfance, on entend souvent la question: «Qu’est-ce que tu veux faire quand tu seras grand ? ». Le travail devrait être synonyme de réussite et de satisfaction, mais il est trop souvent synonyme de fatigue et d’emprisonnement. Aujourd’hui, beaucoup pensent que l’on ne passe pas assez de temps avec sa famille, ses amis. Il est urgent de revoir la place occupée par le travail dans notre société. Certains pensent que travailler moins permettrait d’avoir plus de temps libre pour mieux vivre.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_253',
  'Thème du débat : « Le Travail : Favorable Ou Défavorable ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les animaux sauvages ne devraient pas être confinés dans des zoos, car cela ne correspond pas à leur habitat naturel. Il décrit les zoos comme des prisons pour les animaux, citant l’exemple d’ours polaires maintenus dans des environnements où la température atteint 15 degrés. Enfin, les animaux nécessitent un environnement naturel et la liberté.

Document B :
Certaines personnes trouvent la publicité ennuyeuse, mais, à mon avis, elle est indispensable pour le commerce et les entreprises. Grâce à la publicité, on fait connaître un produit ou un service. Et puis, parfois, elles sont drôles ! J’aime bien les écouter quand je suis en voiture. Cela me permet aussi d’être informé des nouveautés et des promotions. Personnellement, j’adore comparer les articles : je peux ainsi faire beaucoup d’économies sur mes achats. Enfin, beaucoup de personnes jouent à des jeux gratuits sur leur téléphone : sans publicité, ces jeux seraient tous payants. 
 Quentin, 28 ans.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_254',
  'Thème du débat : « Les Parcs Zoologiques : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez lu cette annonce, vous écrivez un article pour les lecteurs du site “www.manger-international.com”.  Vous expliquez comment mangent les habitants de votre pays et vous indiquez quelles habitudes vous plaisent ou vous déplaisent, et pourquoi.

Document B :
Beaucoup de gens pensent encore que les jeux vidéo nous rendent bêtes. Pourtant de nombreuses études prouvent le contraire. 
 Ainsi, selon une de ces études, les utilisateurs de jeux de course développeraien leur sens de l’orientation, leur mémoire et la précision de leurs mouvements. D’autres études montrent clairement une amélioration de la rapidité et de la concentration de tous les joueurs. Et c’est sans parler des jeux d’entraînement destinés aux personnes âgées pour consolider la mémoire et la vivacité d’esprit… Bref, c’est scientifique, le jeu vidéo rend plus intelligent !',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_255',
  'Thème du débat : « Les Publicités, Pour ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Beaucoup de villes se lancent dans des projets d’interdiction de voitures en zone urbaine sans mettre en place les outils et les infrastructures nécessaires pour réussir cette transition. Certes, en diminuant les voitures, on aura moins d’embouteillages, de stress et surtout un air beaucoup moins pollué, mais en contrepartie, il faut prévoir entre- autres de gigantesques parkings pour garer les voitures, opter davantage pour le transport en commun (métros et bus) et prévoir des autorisations de circulation pour certains corps de métiers (comme la police, les urgentistes, les livreurs, …)

Document B :
Je fais souvent mes voyages avec des compagnies aériennes à bas prix. Les compagnies Low-cost mettent à disposition des prix inférieurs à ceux proposés par les compagnies aériennes régulières. Cela me coûte des fois moins chère que de voyager en voiture ou en train. Avec ces tarifs-là, vous en doutez qu’il y a un hic, en effet, vous n’aurez le droit à aucun service à bord (ni aliments, ni boissons). Je dirais donc, que le low-cost n’est surtout pas fait pour les vols long courrier.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_256',
  'Thème du débat : « Les Jeux Vidéo ont-ils un Impact sur notre Comportement ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous répondez à votre ami Camille. Dans votre message, vous décrivez votre activité sportive et vous donnez des informations utiles (lieu, durée, prix, etc.).

Document B :
« Tout quitter pour changer de vie ? Il y a deux ans, nous avons décidé de changer de vie. Paul a quitté son poste de banquier à Paris et nous avons ouvert une boulangerie à Calgary ! Que pensez-vous de cette décision ? Avez-vous déjà vécu un grand changement, professionnel ou personnel ? Paul et Naïma »',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_257',
  'Thème du débat : « L’Interdiction des Voitures dans les Centres-Villes »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
De nos jours, les entreprises veulent toujours plus de productivité et d’efficacité, et les employés passent plus de temps sur les lieux de travail. Les entreprises cherchent toujours des moyens ou astuces pour convaincre leurs employés de travailler plus et qu’elles pensent à leur santé. Moi, ce qui m’importe c’est de faire mon job sur mon temps de travail réel sans être obligé de faire des rallonges en heures supplémentaires. « Florian, ingénieur ».

Document B :
Le port de l’uniforme étouffe et écrase la personnalité des garçons. Ils ne peuvent s’habiller comme ils veulent, en aucune circonstance. De l’autre coté de l’échelle (chez les pros) il y a des gens qui préféraient pour eux-mêmes et leurs enfants, avoir la possibilité de s’exprimer à travers l’habillement, en décidant eux-mêmes ce qu’ils porteront chaque jour. Ainsi, avec un uniforme, les jeunes qui aiment s’exprimer à travers la mode, se démarquer de la foule grâce à un accessoire ou un vêtement particulier, se retrouveront déçus et emprisonnés dans l’uniforme.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_258',
  'Thème du débat : « L’Interdiction des Voitures dans les Centres-Villes »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Document 2 : (Paul 63 ans ) : Pour aider les personnes vivant dans la précarité, on doit s’investir davantage dans les associations caritatives. Personnellement, c’est ce que je fais; je suis bénévole dans une association située dans mon quartier. Elle a pour principal but, aider les sans-abris à trouver un logement et un travail afin au’ils vivent le plus normalement possible. Cette action est plus bénéfique à long terme car elle permet de les rendre autonomes.

Document B :
La vie en colocation offre de nombreux avantages. Partager un logement avec d’autres personnes permet de réduire les dépenses, que ce soit le loyer, les factures ou les frais généraux. De plus, cela favorise les interactions sociales et les échanges culturels. Vivre avec des colocataires permet de rencontrer des individus de différents horizons, de nouer des amitiés et de partager des expériences enrichissantes.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_259',
  'Thème du débat : « Les Vols A Bas Prix : Pour ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Il parle des cuisiniers qui ont appris le métier de cuisiniers sur internet et qui ont le buzz sur les réseaux sociaux il raconte aussi l’histoire d’une amatrice qui est devenue professionnelle et qui a rédigé plusieurs livres sur la cuisine pour les amateurs de cuisine à la maison.

Document B :
“Je suis en faveur des distributeurs de boissons dans les lycées. Premièrement, ils offrent une commodité supplémentaire pour les élèves, notamment pour ceux qui n’ont pas le temps de passer à la cafétéria pendant les pauses. Deuxièmement, s’ils sont bien gérés, ces distributeurs peuvent offrir une gamme de boissons saines, comme de l’eau, du jus de fruits pur et des boissons aux fruits sans sucre ajouté. Ces distributeurs peuvent être une source de revenus supplémentaire pour l’école, qui peut être réinvestie dans l’amélioration des infrastructures ou des programmes scolaires.”',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_260',
  'Thème du débat : « Les Vols À Bas Prix : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les restaurants rapides proposent des plats équilibrés et variés et ils respectent les normes d’hygiène et les variétés de produits qui sont bonnes et c’est le client qui compose son menu donc il est responsable.

Document B :
Les fast foods, en raison de leur impact néfaste sur la santé, sont responsables de l’apparition de diverses maladies. Leur consommation régulière peut entraîner des problèmes tels que l’obésité, les maladies cardiovasculaires et le diabète. Il est important de limiter leur consommation afin de préserver notre bien-être.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_261',
  'Thème du débat : « Restauration Rapide. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La vie en colocation offre de nombreux avantages. Partager un logement avec d’autres personnes permet de réduire les dépenses, que ce soit le loyer, les factures ou les frais généraux. De plus, cela favorise les interactions sociales et les échanges culturels. Vivre avec des colocataires permet de rencontrer des individus de différents horizons, de nouer des amitiés et de partager des expériences enrichissantes.

Document B :
La colocation peut cependant présenter des défis. Les différences de personnalité et de mode de vie entre les colocataires peuvent entraîner des tensions. La gestion des responsabilités et des tâches ménagères peut également être source de conflits. De plus, la colocation peut limiter l’intimité et l’espace personnel. Il est important d’établir une communication ouverte et respectueuse, ainsi que des règles de vie commune, pour favoriser une cohabitation harmonieuse.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_262',
  'Thème du débat : « Les Jeux Vidéo »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
“Je suis fermement pour le travail des jeunes pendant les vacances. C’est une excellente occasion d’acquérir des compétences pratiques, d’apprendre à travailler en équipe et de découvrir différentes industries. Les jeunes peuvent gagner de l’argent qu’ils peuvent économiser pour l’avenir ou utiliser pour financer des activités ou des loisirs. De plus, le fait d’avoir une expérience de travail sur leur CV peut leur donner un avantage lorsqu’ils postulent pour des emplois ou des stages à l’avenir. Les vacances d’été sont longues et il y a amplement de temps pour se reposer et travailler.

Document B :
Opinion 2 : Élise, une psychologue pour adolescents',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_263',
  'Thème du débat : « Les devoirs à la maison : pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Je sais que tu vas dans une salle de sport. Qu’est ce que tu penses de cette salle ? Peux-tu m’en dure un peu plus ? Je voudrais savoir si elle est bien !

Document B :
Il est aujourd''hui possible de fabriquer soi-même tout type de produits à la maison: des shampooings, des savons, des crèmes, du maquillage mais aussi des produits d''entretien pour faire le ménage. C''est formidable car on peut ainsi contrôler leur composition. Il est préférable de sélectionner des ingrédients et des parfums naturels qui ne contiennent pas d''éléments chimiques. Par ailleurs, la fabrication maison permet de reduire les emballages etadonc les déchets.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_264',
  'Thème du débat : « L’aide Aux Personnes Pauvres : »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
J’ai pris l’habitude, depuis des années maintenant, de donner un peu de mon temps et de mon argent afin d’aider les personnes vivant dans la précarité extrême, surtout ceux qui vivent sans abri en période hivernale. Pour our moi, c’est un devoir d’aider et de contribuer afin que ces personnes puissent vivre le ou des normalement possible. En assistant des pauvres ou des associations, on se sent utile au sein d’une société qui devient de plus en plus impitoyable.

Document B :
Pour aider les personnes vivant dans la précarité, on doit s’investir davantage dans des associations caritatives. Personnellement, c’est ce que je fais, je suis bénévole dans une association située dans mon quartier. Elle a pour principal but, aider les sans-abris à trouver un logement et un travail afin qu’ils vivent le plus normalement possible. Cette action est plus bénéfique à long terme car elle permet de les rendre autonomes.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_265',
  'Thème du débat : « Vivre En Colocation : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez invité votre ami Cédric à votre mariage au Château de Chombony et il vous a répondu qu’il ne connait pas ce château. Décrivez à votre ami (lieu, localisation, transports, etc.).

Document B :
Dans votre blog, Racontez votre expérience de l’apprentissage d’une langue étrangère (vous écrivez sur un forum internet en racontant votre expérience en apprenant une langue étrangère).',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_266',
  'Thème du débat : « Cuisinier Amateur Ou Cuisinier Professionnel ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Je suis votre amie Anna et je compte passer un weekend dans ta ville.  Donnez-moi des informations sur les moyens de transport pour explorer la ville. Répondez à Anna dans un message.

Document B :
Vous avez assisté à une fête de voisins du quartier,  écrivez un blog pour montrer pourquoi vous avez aimé cette fête.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_267',
  'Thème du débat : « Les Distributeurs De Boissons Dans Les Lycées: Pour Ou Contre? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous allez bientôt déménager. Écrivez un message à votre ami(e) pour demander son aide en fournissant les informations (date, lieu, transports, etc.).

Document B :
Vous faites une réclamation par rapport aux mauvaises prestations d’une agence de voyage suite à un voyage mal organisé. Exprimez votre mécontentement.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_268',
  'Thème du débat : « Les Jeux Vidéo : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous partez en voyage et vous laissez votre appartement à un ami qui veut venir rester chez-vous pendant vos vacances.  Vous lui envoyez un message pour décrire votre appartement (immeuble, logement, accès…).

Document B :
Ecrivez un article de blog sur votre souvenir de voyage que vous avez aimé le plus.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_269',
  'Thème du débat : « Vivre Chez Ses Parents, Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Ecrivez un message à vos amis pour les inviter à votre anniversaire et leur raconter comment va se dérouler votre fête.

Document B :
Répondez en commentaire à une publication sur Facebook au sujet des études à l’étranger en citant les avantages et les inconvénients de cette expérience',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_270',
  'Thème du débat : « Les Nouvelles Technologies Pour Les Enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Votre ami veut se mettre au sport.  Vous lui envoyez un message pour lui conseiller une salle de sport situé dans votre quartier (localisation, prix, type d’activités, etc…)

Document B :
Vous avez participé à un événement qui vous a marqué (anniversaire, mariage, etc…).  Racontez votre souvenir.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_271',
  'Thème du débat : « La Lecture Pour Les Enfants »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous faites du sport dans un club. Vous venez de remporter une compétition. Vous écrivez un courriel à vos amis pour leur raconter cet évènement sportif et annoncer votre réussite sportive.

Document B :
« Le site colocation.com recherche des témoignes sur vos expériences de colocation. Écrivez-nous ! » Vous avez déjà habité en colocation avec des amis. Vous racontez votre expérience aux membres du site internet. Vous donnez votre opinion sur ce mode de logement.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_272',
  'Thème du débat : « Le Grossissement Des Villes »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Écrivez un message dans le journal de votre université pour rechercher un partenaire avec qui fait du sport.

Document B :
Écrivez dans un article un message pour raconter votre arrivée dans un pays étranger en donnant vos impressions.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_273',
  'Thème du débat : « Rôle De La Télévision Dans L''éducation Des Enfants. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Salut ! 
 Je cherche un endroit pour déjeuner en plein air ce week-end. Qu’est-ce que tu me propose ? 
 A bientôt, 
 Barbara. 
 Vous répondez à votre amie Barbara. Vous décrivez le lieu (parc, jardin, terrasse, etc.)

Document B :
Vous avez visité un nouveau pays pendant vos vacances. Sur un site internes, vous racontez votre expérience et vous donnez votre opinion sur ce pays.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_274',
  'Thème du débat : « l''utilisation du plastique, pour ou contre »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
votre ami(e) veut découvrir la région dans laquelle vous habitez.  Écrivez lui un message pour lui proposer des sites à visiter.

Document B :
Vous avez participé à un cours de sport dans une salle.  Écrivez un article dans votre blog parlant de  cette expérience et en exprimant également votre avis par rapport à cette salle.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_275',
  'Thème du débat : « Livraison Des Repas Au Bureau : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Je vais bientôt vivre dans ton quartier. Je cherche un endroit sympathique pour faire mes courses. Est-ce que tu connais un marché intéressant ?

Document B :
Merci d’avance et à bientôt !',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_276',
  'Thème du débat : « Le Grossissement Des Villes »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Je cherche un endroit pour déjeuner en plein air ce week-end. Qu’est-ce que tu me propose ?

Document B :
Vous répondez à votre amie Barbara. Vous décrivez le lieu (parc, jardin, terrasse, etc.)',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_277',
  'Thème du débat : « Rôle De La Télévision Dans L''éducation Des Enfants. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Amicha s’oppose fermement à l’utilisation du plastique, mettant en avant son impact environnemental dévastateur. Elle argue que les déchets plastiques polluent les océans et les écosystèmes, causant des dommages irréparables. Amicha milite pour des alternatives écologiques et durables, insistant sur l’urgence de renoncer au plastique pour protéger l’environnement et la santé publique.

Document B :
votre ami(e) veut découvrir la région dans laquelle vous habitez.  Écrivez lui un message pour lui proposer des sites à visiter.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_278',
  'Thème du débat : « l''utilisation du plastique, pour ou contre »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Cette pratique révèle souvent des inconvénients à cause de sa notoriété montante. Certains jours, il arrive que les responsables de livraisons peuvent être envahis par un grand nombre de livraisons à faire et cela risque de générer des perturbations liées au stress de l’attente. De même pour les employés, une trop longue heure de travail peut causer un état de fatigue si ce dernier ne quittera pas son bureau pour le repas. Dans tous les cas, il est recommandé de toujours marquer des temps de pause lors des durs labeurs.

Document B :
Je vais bientôt vivre dans ton quartier. Je cherche un endroit sympathique pour faire mes courses. Est-ce que tu connais un marché intéressant ?',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_279',
  'Thème du débat : « Livraison Des Repas Au Bureau : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous faites partie d’une association de quartier qui propose des activités aux enfants (aide aux devoirs, sorties, jeux, etc.) Sur votre site internet, vous racontez votre expérience et vous expliquez pourquoi ce type d’association est utile.

Document B :
Depuis plusieurs années maintenant, de nombreux lecteurs ont décidé de remplacer la bibliothèque traditionnelle par des livres numériques. Selon eux, l’avantage est avant tout économique. D’une part, le livre numérique permet d’économiser du papier, d’autre part la version numérique d’un livre est généralement moins chère que la version papier. Les livres numériques ont un autre avantage : ils permettent une ouverture sur le monde pour les personnes en situation de handicap. Certaines options, comme la possibilité d’augmenter la taille des lettres, facilitent la lecture pour les personnes malvoyantes.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_280',
  'Thème du débat : « Sujets d''actualité »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Envoyez-nous vos témoignages sur francetelevisions.fr.

Document B :
Vous avez passé des vacances formidables dans une belle région de votre pays.Vous écrivez un message à vos amis dans lequel vous racontez votre expérience. Vous expliquez pourquoi vous avez beaucoup aimé ce séjour.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_281',
  'Thème du débat : « les animaux de compagnie pour les enfants, pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Gagnez deux billets pour la destination de votre choix avec la compagnie Air Tropiques. Racontez votre plus beau voyage sur notre forum »

Document B :
Écrivez un message sur le forum de la compagnie Air Tropiques. Vous racontez votre plus beau voyage (destination, activités, &#8230;) et vous dites pourquoi&#8230;',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_282',
  'Thème du débat : « le vélo en ville, pour ou contre? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La bibliothèque de votre ville organise une rencontre avec un écrivain. Écrivez un message à votre ami(e) pour l’inviter à cet évènement.

Document B :
Vous avez participé à un évènement nommé ” La semaine du gout “. Écrivez un article de blog pour raconter cette expérience.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_283',
  'Thème du débat : « L''école à domicile, pour ou contre? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Participez à notre concours pour gagner un séjour pour deux personnes dans la ville de votre choix. Rédigez un article sur le thème : <<< La vie de mon artiste préféré(e) > ».

Document B :
Vous participez à ce concours. Vous expliquez pourquoi vous avez choisi cet(te) artiste et vous racontez sa vie.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_284',
  'Thème du débat : « Faire ses courses alimentaires chez les
producteurs locaux ou au supermarché »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous êtes locataire d’un appartement trop grand pour vous. Écrivez une annonce dan un journal pour chercher un colocataire. Il faut mentionner ; la superficie, caractère du colocataire,  prix, etc).

Document B :
Vous venez de commencé une nouvelle activité de loisir (Sport, dance, etc.). Écrivez un article sur votre blog pour parler de cette expérience.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_285',
  'Thème du débat : « L’art Urbain : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Votre ami Cédric a accepté de garder votre maison et jardin pendant vos vacances. Écrivez un message pour lui dire ce qu’il doit faire.

Document B :
Vous faites une réclamation par rapport aux mauvaises prestations d’une agence de voyage suite à un voyage mal organisé. Exprimez votre mécontentement.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_286',
  'Thème du débat : « Les Parcs Zoologiques : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Le texte affirme que les zoos ont beaucoup d’avantages, même pour les animaux en la voie de disparition, les animaux sont bien soignées dans les zoos. Les études montrent que le nombre de reproduction a augmenté grâce aux zoos et ils peuvent sauver la vie des animaux.

Document B :
Le texte a montré qu’il ne faut pas mettre les animaux sauvages dans les zoos parce que ce n’est pas leur environnement. C’est un prison pour eux. On trouve des ours polaires dans un zoo dont la température est de 15 degrés. Les animaux ont besoin de la nature et de la liberté.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_287',
  'Thème du débat : « Les Animaux de Compagnie au Travail »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Venir au bureau avec son animal de compagnie, c''est à la mode. L''intérêt de cette présence ? C''est simple: diminuer le stress des employés. La présence d''un chien ou d''un chat change l''ambiance générale d''une entreprise : elle réduit les tensions entre collègues, ce qui n''est pas négligeable car chaque année, l''État français dépense entre 2 et 3 milliards d''euros pour soigner les salariés malades du stress. Selon une enquête, un quart des employés pensent aussi que la présence des animaux permet d''être plus motivé au travail.

Document B :
« Dans l''entreprise où je travaille, les employés sont autorisés à venir avec leur animal de compagnie, chat ou chien. Personnellement, cela me dérange. Je ne suis pas très à l''aise avec les animaux, qui peuvent avoir des comportements imprévisibles. D''autre part, je trouve que cela peut poser des problèmes de santé. Que faire si un employé est allergique aux chats ? Sera-t-il obligé de rester enfermé dans son bureau? Et puis c''est aussi une source de distraction. Mes collègues et moi ne serons pas plus productifs grâce à un chien ou un chat ! »',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_288',
  'Thème du débat : « L''uniforme Scolaire : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez déjà étudié dans une université à l’étranger.  Écrivez un article sur votre Blog pour raconter cette expérience.

Document B :
Le port de l’uniforme étouffe et écrase la personnalité des garçons. Ils ne peuvent s’habiller comme ils veulent, n’en écrase la peuvent aucune circonstance. De l’autre côté de l’échelle (chez les pros) il y a des gens qui préféraient pour eux-mêmes et leurs enfants, avoir la possibilité de s’exprimer à travers l’habillement, en décidant eux-mêmes ce qu’ils porteront chaque jour. Ainsi, avec un uniforme, les jeunes qui aiment s’exprimer à travers la mode, se démarquer de la foule grâce à un accessoire ou un vêtement particulier, se retrouveront déçus et emprisonnés dans l’uniforme.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_289',
  'Thème du débat : « Faut il mettre les photos sur les CV »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez décidé de ne plus utiliser les réseaux sociaux ( twitter Instagram Facebook et autres). 
 Écrivez un message à vos amis en citant les raisons derrière cette décision.

Document B :
On parle de l’inutilité de la photo sur le cv tant que ce qui est important sont les diplômes requis et l’expérience professionnelle. Les employeurs n’aiment pas avoir des photos, une étude montre que c’est une perte de temps. La photo sur un cv ne doit pas etre obligatoire car elle peut influencer les employeurs, certains employeurs peuvent choisir un candidat en se basant sur sa couleur (une sorte de discrimination).',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_290',
  'Thème du débat : « l''utilisation du plastique, pour ou contre »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous répondez à votre amie Barbara. Vous décrivez le lieu (parc, jardin, terrasse, etc.)

Document B :
Vous avez visité un nouveau pays pendant vos vacances. Sur un site internes, vous racontez votre expérience et vous donnez votre opinion sur ce pays.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_291',
  'Thème du débat : « Les Vols À Bas Prix : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Écrivez un courriel à vos amis pour les inviter à un anniversaire surpris de votre meilleur ami.  (Lieu, date, horaire, etc.).

Document B :
Vous avez participé à une brocante (achat / vente de produits d’occasion) dans votre ville.  Sur votre blog personnel racontez pourquoi vous avez aimé cette activité.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_292',
  'Thème du débat : « L''interdiction des voitures en ville. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous voulez communiquer avec quelqu’un en français en toute convivialité. Vous écrivez un courriel à cette adresse(&#8230;) pour qu''on vous propose quelqu’un (centre d’intérêt, présentez vous&#8230;)

Document B :
Écrivez un message à vos amis pour leur raconter à propos d''une fête à laquelle vous avez assisté en famille.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_293',
  'Thème du débat : « Menus Sans Viande à La Cantine Scolaire. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Écrivez un message à vos amis pour leur proposer d''organiser une grande fête. Demandez- leur de vous aider.

Document B :
Racontez sur un site internet une compétition sportive à laquelle vous avez participé.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_294',
  'Thème du débat : « La vie à la campagne ou en ville »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Écrivez un message à vos amis pour les inviter à découvrir une ville touristique.

Document B :
Vous avez participé à un festival (gastronomie, musique, sport). Racontez ce qui ne vous a pas plu dans cette expérience.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_295',
  'Thème du débat : « Cours de langue à distance »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Tu as commencé ton nouveau travail !

Document B :
C’est comment ? Tu es content(e) ?',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_296',
  'Thème du débat : « Faut il mettre les photos sur les CV »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
On parle de l’inutilité de la photo sur le cv tant que ce qui est important sont les diplômes requis et l’expérience professionnelle. Les employeurs n’aiment pas avoir des photos, une étude montre que c’est une perte de temps. La photo sur un cv ne doit pas etre obligatoire car elle peut influencer les employeurs, certains employeurs peuvent choisir un candidat en se basant sur sa couleur (une sorte de discrimination).

Document B :
Christophe adhère à l’idée que la présence d’une photo sur le CV ne sera pas un critère de sélection mais elle est indispensable pour quelques métiers tel que une hôtesse d’accueil, la photo est nécessaire, il donne une idée sur le candidat et certaines employeurs veulent voir la photo pour décider pour ou contre un candidat.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_297',
  'Thème du débat : « Habitudes alimentaires pour ou contre? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Le livre numérique remplacera-t-il le livre papier ? « Non », répondront la plupart des lecteurs. Le livre papier est un beau support. Quel plaisir de le prêter aux gens qu’on aime ou de l’offrir en glissant un petit mot dedans ! Le livre papier a une histoire, l’odeur du neuf ou de l’ancien… Il transmet beaucoup d’émotions alors que le livre numérique à un côté un peu impersonnel. De plus, les livres numériques demandent de posséder un minimum de connaissances en informatique, ce qui peut être une difficulté pour certaines personnes.

Document B :
Écrire un message à votre amie pour lui proposer un lieu de camping (lieu,date, activités&#8230;)',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_298',
  'Thème du débat : « Menus Sans Viande à La Cantine Scolaire. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Racontez sur un site internet une compétition sportive à laquelle vous avez participé.

Document B :
De plus en plus d’écoles décident de mettre en place un menu sans viande dans les cantines, au moins deux fois par semaine. Certaines études ont montré que les enfants consomment trop de protéines animales. C’est donc une question de santé : les écoles ont choisi de remplacer la viande par d’autres produits (soja, céréales, légumes), moins gras et utiles à la croissance des enfants. Ces menus sans viandes à la cantine reviennent moins cher aux familles. Cette idée plaît beaucoup aux parents comme aux enfants.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_299',
  'Thème du débat : « La vie à la campagne ou en ville »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez participé à un festival (gastronomie, musique, sport). Racontez ce qui ne vous a pas plu dans cette expérience.

Document B :
À mon avis, le fait de vivre en ville, cela vous donne la possibilité de vous divertir de plusieurs manières ; comme aller au cinéma, déjeuner dans un restaurant faire du shopping… Tout est à côté, vous n’avez pas besoin de parcourir plusieurs kilomètres pour prendre un taxi ( si le trajet est un peu long) et vous aurez à disposition tout ce dont vous désirez. Même les amoureux des évènements culturels sont servis ; musée, théâtre, opéra… tout y est !',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_300',
  'Thème du débat : « Cours de langue à distance »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
C’est comment ? Tu es content(e) ?

Document B :
Vous répondez à votre ami Ali. Dans votre message, vous décrivez votre nouveau travail (lieu, collègues, etc.) et vous donnez vos impressions.',
  NULL,
  true
);

INSERT INTO public.taches (epreuve, numero_tache, reference, consigne, duree_secondes, actif) VALUES
(
  'expression_ecrite',
  3,
  'EE_T3_301',
  'Thème du débat : « La restauration rapide »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les restaurants rapides se distinguent par leur engagement à proposer une variété de plats équilibrés, respectant strictement les normes d''hygiène. En laissant aux clients la liberté de composer leur propre menu, ces établissements les responsabilisent dans leurs choix alimentaires, tout en satisfaisant leurs préférences gustatives.

Document B :
Les spécialistes affirment que manger régulièrement dans des restaurants de fast-food, qui proposent de la restauration rapide, est dangereux pour la santé. La nourriture servie est souvent la même : frites, hamburgers et boissons sucrées. Ces aliments contiennent une grande quantité de calories, bien trop pour un seul repas. De plus, la plupart des produits dans ces restaurants sont emballés dans du plastique. Par conséquent, manger dans un fast-food augmente la production de déchets plastiques, ce qui est nuisible pour l’environnement.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_302',
  'Thème du débat : « Caméras De Surveillance : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
De nos jours, il y a de plus en plus de caméras de surveillance dans les villes. La vidéosurveillance est appréciée par les Français car cela leur donne un sentiment de sécurité. D''après un sondage, 75% d''entre eux sont pour le développement de la vidéosurveillance. 
 Ils seraient d''accord pour être filmés, mais seulement dans l''espace public: la rue, les magasins ou encore les transports. Cependant, 
 ils refusent d''être surveillés par leur employeur. En France, peu de caméras de vidéosurveillance sont installées sur le lieu de travail.

Document B :
Certaines enquêtes montrent que la vidéo surveillance coûte cher et que ses résultats sont insuffisants. D''une part, la présence des caméras est facile à remarquer. Par conséquent, la vidéo surveillance est inutile pour éviter les vols, la consommation de drogue et la violence dans les villes. D''autre part, l''utilisation de vidéo surveillance demande beaucoup de personnel. Une étude allemande montre que sept personnes par caméra sont nécessaires pour analyser les informations.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_303',
  'Thème du débat : « Livraison Des Repas Au Bureau : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Grâce à la livraison en entreprise, les employés bénéficieront d’un gain de temps notable. Il n’est plus question d’aller sortir loin du lieu de travail pour trouver de quoi manger. En complément, l’argent et l’énergie économisée permettent d’être encore plus efficace au travail. Sans pour autant mettre fin à une session importante liée au travail, le repas sera déjà prêt et pourra attendre la fin d’une conférence, d’une réunion ou d’un rendez-vous. Il s’agit d’une véritable solution dédiée aux entreprises ayant une activité intense et qui requiert la présence continue de leurs employés. 
 Et en ce qui concerne les inconvénients ?

Document B :
Cette pratique révèle souvent des inconvénients à cause de sa notoriété montante. Certains jours, il arrive que les responsables de livraisons peuvent être envahis par un grand nombre de livraisons à faire et cela risque de générer des perturbations liées au stress de l’attente. De même pour les employés, une trop longue heure de travail peut causer un état de fatigue si ce dernier ne quittera pas son bureau pour le repas. Dans tous les cas, il est recommandé de toujours marquer des temps de pause lors des durs labeurs.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_304',
  'Thème du débat : « La Chasse Aux Animaux : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
“Je suis de ceux qui n’arrivent pas à comprendre comment l’on peut prendre du plaisir à tuer des animaux. Je suis de ceux qui n’arrivent pas à comprendre comment on peut prétendre aimer la nature alors qu’on la détruit”

Document B :
“Les gens chassent pour différentes raisons : la subsistance, le commerce, la conversation et l’aménagement de la faune, la protection de la propriété, l’exercice, le loisir et le prestige.”',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_305',
  'Thème du débat : « La Sieste Au Travail : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Augmenter la productivité du personnel et les bienfaits pour leurs santé ainsi que diminuer le stress.

Document B :
montre que malgré de nombreuses études qui prouvent ces bienfaits, il est assez difficile en termes de faisabilité. En effet c''est pas dans les moyens de toutes les entreprises de mettre en place des salles dédiés à cette pratique.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_306',
  'Thème du débat : « Le Bien Être Au Travail »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Je travaille depuis 5 ans dans une grande entreprise technologique. Pour moi, le bien-être au travail rime avec flexibilité. Grâce au télétravail et aux horaires ajustables, je ressens un équilibre entre ma vie professionnelle et personnelle. Cependant, je souligne l’importance d’espaces de détente au bureau pour les moments où je m’y trouve.

Document B :
Je suis cadre dans une PME, j’associe bien-être au travail à la reconnaissance. Les retours positifs, un management bienveillant et les formations continues ont un impact profond sur ma motivation. Toutefois, je déplore l’absence d’initiatives pour la santé mentale, suggérant que des ateliers de méditation ou des conseils psychologiques pourraient être bénéfiques.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_307',
  'Thème du débat : « Cuisinier Amateur Ou Cuisinier Professionnel ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les amateurs ont fait des recettes réussies, mais ils manquent toujours des compétences et des technique, c''est pourquoi la formations et l''expérience sont nécessaires pour être un vrai cuisinier.

Document B :
Il parle des cuisiniers qui ont appris le métier de cuisiniers sur internet et qui ont le buzz sur les réseaux sociaux il raconte aussi l''histoire d''une amatrice qui est devenue professionnelle et qui a rédigé plusieurs livres sur la cuisine pour les amateurs de cuisine à la maison.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_308',
  'Thème du débat : « La Restauration Rapide : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Je trouve la restauration rapide très pratique lorsqu’il est pressé. Selon moi, les chaînes de fast-food ont fait des efforts pour proposer des options plus saines. J’apprécie particulièrement la possibilité de commander en ligne et de récupérer sa commande rapidement, ce qui me permet de gérer mon temps efficacement pendant mes journées chargées.

Document B :
J’ai eu une expérience déplaisante avec la restauration rapide. J’ai trouvé que les aliments étaient souvent de qualité médiocre et trop gras. De plus, j’ai été déçue par le manque d’options végétariennes et saines dans la plupart des fast-foods. Pour moi, il vaut mieux prendre le temps de préparer un repas maison sain et équilibré.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_309',
  'Thème du débat : « La Gratuité Des Musées : Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
la gratuité des musées peut entraîner une sur fréquentation, ce qui nuit à la qualité de l’expérience des visiteurs. De plus,  cela puisse réduire les ressources financières des musées, affectant ainsi leur entretien et la préservation des œuvres. Un tarif réduit serait une meilleure solution pour rendre la culture accessible tout en soutenant les musées.

Document B :
La gratuité des musées est une excellente initiative. Cela rend la culture accessible à tous, indépendamment de leur situation financière. J’ai pu visiter plusieurs musées gratuitement, ce qui m’a permis d’enrichir mes connaissances sans me soucier du coût. Pour moi, la gratuité des musées contribue à l’éducation du public et au partage du patrimoine culturel.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_310',
  'Thème du débat : « Le Contrôle Parental »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Lorsque ma fille a accidentellement vu du contenu inapproprié en ligne, j’ai immédiatement activé le contrôle parental. Cela l’a protégée des dangers en ligne et m’a rassuré en tant que parent. Depuis, elle navigue plus sereinement, et je peux souffler, sachant qu’elle est en sécurité.

Document B :
Mon fils s’est senti étouffé par le contrôle parental que j’avais installé. Il m’a avoué qu’il se sentait méfiant et limité. Au lieu de le protéger, cela a creusé un fossé entre nous. J’ai choisi l’éducation digitale et le dialogue plutôt que la restriction.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_311',
  'Thème du débat : « La sévérité des parents envers leurs enfants : approches divergentes »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Une étude menée par le Centre de recherche sur la parentalité de l’Université de Toronto en juin dernier a révélé que la majorité des parents adoptent des approches plus bienveillantes envers leurs enfants qu’auparavant. Cette étude a examiné un échantillon représentatif de mille familles dans différentes régions du pays et a montré que les parents encouragent une communication ouverte avec leurs enfants et adoptent des approches moins autoritaires.

Document B :
Un article d’opinion paru dans un magazine populaire en mars 2023 présente des témoignages de parents qui ont recours à des méthodes de discipline plus strictes, telles que des privations de liberté, des punitions corporelles et des critiques constantes. Certains parents estiment que ces approches sont nécessaires pour aider leurs enfants à développer leur responsabilité et leur discipline dans un monde de plus en plus compétitif. Cependant, de nombreux experts en éducation considèrent ces méthodes comme inappropriées et préconisent des approches plus positives et coopératives pour guider les enfants vers un comportement approprié.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_312',
  'Thème du débat : « Les Distributeurs De Boissons Dans Les Lycées: Pour Ou Contre? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
“Je suis en faveur des distributeurs de boissons dans les lycées. Premièrement, ils offrent une commodité supplémentaire pour les élèves, notamment pour ceux qui n’ont pas le temps de passer à la cafétéria pendant les pauses. Deuxièmement, s’ils sont bien gérés, ces distributeurs peuvent offrir une gamme de boissons saines, comme de l’eau, du jus de fruits pur et des boissons aux fruits sans sucre ajouté. Ces distributeurs peuvent être une source de revenus supplémentaire pour l’école, qui peut être réinvestie dans l’amélioration des infrastructures ou des programmes scolaires.”

Document B :
“Je suis contre l’installation de distributeurs de boissons dans les lycées. Ma principale préoccupation est liée à la santé des élèves. Malheureusement, beaucoup de ces distributeurs sont remplis de boissons sucrées et de sodas qui contribuent à l’obésité infantile et à d’autres problèmes de santé comme le diabète. Même les jus de fruits, qui peuvent sembler sains, contiennent souvent beaucoup de sucre. Les écoles devraient être des lieux qui encouragent des habitudes alimentaires saines et je crains que la présence de ces distributeurs n’encourage une consommation excessive de boissons sucrées.”',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_313',
  'Thème du débat : « Le Contrôle Parental »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Répondre au courriel de votre ami Lucas pour lui donner les informations sur les nouveaux locaux de votre entreprise  (lieu, disposition des pièces, équipements…)

Document B :
Vous avez assisté à un événement intitulé “une semaine sans voiture”. Racontez dans un blog l’expérience que vous avez vécue et donnez votre impression sur cette initiative.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_314',
  'Thème du débat : « Les Vêtements De Marque: Pour Ou Contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Écrivez un courriel à vos amis pour les inviter à un anniversaire surpris pour votre meilleure ami(e), et proposez de lui offrir un cadeau commun  (lieu cadeau, activités, etc.).

Document B :
Votre direction est à la recherche d''une salle pour la fête de fin d''année, capable d''accueillir 100 invités. Rédigez un message à la direction pour leur dire que vous avez trouvé un local idéal. (Lieu, tarifs et services etc.…)',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_315',
  'Thème du débat : « La sévérité des parents envers leurs enfants : approches divergentes »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous voulez organiser une visite culturelle dans votre ville. Vous envoyez un message pour inviter vos amis. Vous leur donner toutes les informations nécessaires (activités, date, lieu, etc.).

Document B :
Vous avez assisté à une soirée écologique pour protéger la planète qui avait lieu dans votre université. Racontez là dans votre blog et expliquez pourquoi vous l’avez aimée.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_316',
  'Thème du débat : « Les Devoirs À La Maison »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Écrivez un email pour répondre à votre ami(e) qui va passer le Week-end dans votre ville. Il faut décrire les moyens de transport.

Document B :
Vous avez assisté à une fête entre voisins dans votre quartier. Dans votre blog décrivez cet évènement et racontez pourquoi vous l’avez aimé.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_317',
  'Thème du débat : « Les publicités alimentaires pour les enfants. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Certaines personnes trouvent la publicité ennuyeuse, mais, à mon avis, elle est indispensable pour le commerce et les entreprises. Grâce à la publicité, on fait connaître un produit ou un service. Et puis, parfois, elles sont drôles ! J''aime bien les écouter quand je suis en voiture. Cela me permet aussi d''être informé des nouveautés et des promotions. Personnellement, j''adore comparer les articles : je peux ainsi faire beaucoup d''économies sur mes achats. Enfin, beaucoup de personnes jouent à des jeux gratuits sur leur téléphone : sans publicité, ces jeux seraient tous payants.

Document B :
La publicité est présente partout dans notre vie de tous les jours : journaux, radios, télévision, téléphone, Internet&#8230; Par exemple, sur certaines chaînes de télévision, les émissions sont coupées par la publicité et c''est agaçant. Puis, recevoir des dizaines de kilos de papier de publicité par an dans la boîte aux lettres, ce n''est pas très respectueux de l''environnement ! Je pense qu''il est nécessaire de faire voter une loi pour réduire les publicités par courrier et à la télévision. Si la publicité était plus discrète, elle serait plus appréciée.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_318',
  'Thème du débat : « Jeux vidéo. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Ce mois-ci, nous nous intéressons aux habitudes alimentaires dans le monde. Racontez-nous comment mangent les habitants de votre pays!

Document B :
Les 10 premiers témoignages seront publiés sur notre site !',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_319',
  'Thème du débat : « Les achats en ligne. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les jeux vidéo, sur console ou sur ordinateur, chez soi ou en salle, seul, avec des amis ou en ligne avec des inconnus, peuvent provoquer une dépendance chez certaines personnes. On parle d''addiction quand le jeu vidéo devient le principal (ou l''unique) centre d''intérêt, à la place d''autres activités (relationnelle, professionnelle, scolaire, loisirs, sport&#8230;). Cette dépendance est particulièrement préoccupante lors de l''adolescence, période importante où les jeux vidéo peuvent avoir un impact négatif sur les résultats scolaires.

Document B :
Un évènement sportif aura lieu dans votre ville bientôt. Faites parvenir un message à vos amis pour les inviter (date, lieu, inscription, etc.).',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_320',
  'Thème du débat : « Cuisinier amateur ou Cuisinier Professionnel ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les magazines nous donne la possibilité d''avoir un contact humain et relation avec les vendeurs + possibilité de voir et de toucher ce qu''on veut … les consommateurs favorisent l''achat traditionnel, visiter des magasins le permette d''échanger des achats insatisfaisants et de se se communiquer avec les vendeurs.

Document B :
Vous avez invité votre ami Éric à votre mariage au château de Chmbony et il vous a répondu qu''il ne connait pas ce château. Décrivez à votre ami (lieu, localisation, transport, etc.).',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_321',
  'Thème du débat : « la chasse aux animaux : pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez participé à un concours pour gagner un séjour de deux semaines dans votre ville préféré. Le thème de ce concours est « Mon artiste préféré » . Écrivez un article de blog pour parler de votre article préféré.

Document B :
“Je suis de ceux qui n’arrivent pas à comprendre comment l’on peut prendre du plaisir à tuer des animaux. Je suis de ceux qui n’arrivent pas à comprendre comment on peut prétendre aimer la nature alors qu’on la détruit”',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_322',
  'Thème du débat : « la consommation de viande : pour ou contre? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous voulez organiser une grande fête, invitez vos amis et demandez leur aide (lieu, date, thème, etc.).

Document B :
Vous avez participé à une compétition sportive, racontez votre expérience sur un site internet et donnez votre avis.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_323',
  'Thème du débat : « les distributeurs de boissons dans les lycées: Pour ou contre? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Votre ami(e) va venir passer le  week-end prochain dans votre ville. Écrivez un message pour lui présenter tous les moyens de transport disponibles dans votre ville (type de transport, circuit, tarif, etc.).

Document B :
Vous avez participé à une fête avec vos voisins. Écrivez un article de blog pour raconter cette expérience.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_324',
  'Thème du débat : « Rôle De La Télévision Dans L''éducation Des Enfants. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Écrivez un message dans le journal de votre université pour rechercher un partenaire avec qui fait du sport.

Document B :
Écrivez dans un article un message pour raconter votre arrivée dans un pays étranger en donnant vos impressions.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_325',
  'Thème du débat : « L''interdiction des voitures en ville. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Écrivez un message pour inviter vos amis à une fête de fin d’année.

Document B :
Vous avez passé des vacances au Canada par le biais d’une agence. Écrivez en commentaire l''expérience que vous avez vécue durant ce voyage.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_326',
  'Thème du débat : « Restauration Rapide. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Votre ami Cédric a accepté de garder votre maison et jardin pendant vos vacances. Écrivez un message pour lui dire ce qu''il doit faire.

Document B :
Vous avez effectué un voyage qui s''est mal passé par le biais d''une agence. Ecrivez leur un courriel pour exprimer votre mécontentement.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_327',
  'Thème du débat : « Animaux De Compagnie. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Répondre à un message de ton ami qui veut s''inscrire dans la même école de langue.

Document B :
Raconte ton expérience de bénévolat dans une association pour les personnes âgées.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_328',
  'Thème du débat : « Vie en colocation entre adultes. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Un nouveau restaurant vient d''ouvrir près de chez vous. Vous écrivez à un(e) ami(e) pour lui proposer d''y aller avec vous. Vous décrivez le restaurant (cuisine, prix, décoration, etc.)

Document B :
Vous avez visité une ville que vous ne connaissiez pas. Vous avez envie de partager votre découverte. Vous postez un message sur un site Internet dédié aux voyages. Racontez votre expérience et expliquez ce qui vous a plu et ce qui vous a déplu dans la ville.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_329',
  'Thème du débat : « Le travail des étudiants pendant les vacances: Pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Invitez vos amis à célébrer votre anniversaire tout en sollicitant leur soutien pour organiser la fête.

Document B :
Vous avez participé à un concours de cuisine, vous allez décrire vos souvenirs dans votre blog en indiquant les détails.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_330',
  'Thème du débat : « le travail : Favorable ou défavorable ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Opinion 2 : Élise, une psychologue pour adolescents

Document B :
« Je suis contre l''idée que les jeunes doivent travailler pendant leurs vacances. Les adolescents sont déjà sous une énorme pression pendant l''année scolaire avec les études, les examens et les activités parascolaires. Les vacances doivent être une période pour eux de se détendre, de se décompresser et de poursuivre des intérêts personnels. Les forcer à travailler pourrait contribuer au stress et à l''épuisement. Il est également important pour les jeunes de disposer de temps non structuré pour explorer leur créativité, passer du temps avec leurs amis et leur famille, et tout simplement être des enfants. Le travail peut attendre. »',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_331',
  'Thème du débat : « Prise de position / Débat »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Répondez sur notre site Internet voyage.internaute.fr

Document B :
Vous écrivez un message sur ce site internet Vous répondez à la question posée en prenant des exemples de votre vie personnelle.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_332',
  'Thème du débat : « Les publicités alimentaires pour les enfants. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Les publicités d''aliments industriels passent en boucle lors des programmes destinés aux enfants. Par conséquent, ces enfants sont influencés par ces pubs et changent de préférences alimentaires demandant aux parents de leur acheter des produits gras, sucrés et salés tout en refusant de manger sainement. Ces publicités alimentaires déséquilibrent totalement l''assiette de nos enfants et a pour résultats directs totalement de problèmes de santé dés le jeune âge. comme la prise de poids qui mène à l''obésité.

Document B :
Pourquoi c''est choquant que des publicités alimentaires soient diffusés lorsque les enfants regardent leurs programmes préférés? C''est et aux aux parents, et aux parents seuls d''éduquer leurs enfants et de leur apprendre à manger d''une manière saine. On ne peut donc en aucun cas interdire à nos enfants de voir des publicités alimentaires pendant leurs programmes de télévision. Il est donc primordial que les parents interviennent afin que ces publicités n''aient pas d''impacts négatifs sur les habitudes alimentaires de leurs enfants.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_333',
  'Thème du débat : « la consommation de viande : pour ou contre? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez participé à une compétition sportive, racontez votre expérience sur un site internet et donnez votre avis.

Document B :
Je suis contre la consommation de viande en raison de préoccupations éthiques, environnementales et sanitaires. Éthiquement, je crois que tous les animaux ont droit à la vie et à la liberté, et que l''élevage industriel implique souvent des traitements inhumains. Environnementalement, l''élevage d''animaux pour la viande est une source majeure de gaz à effet de serre et nécessite une grande quantité de terres et d''eau, ce qui contribue au changement climatique et à la déforestation.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_334',
  'Thème du débat : « les distributeurs de boissons dans les lycées: Pour ou contre? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez participé à une fête avec vos voisins. Écrivez un article de blog pour raconter cette expérience.

Document B :
« Je suis en faveur des distributeurs de boissons dans les lycées. Premièrement, ils offrent une commodité supplémentaire pour les élèves, notamment pour ceux qui n''ont pas le temps de passer à la cafétéria pendant les pauses. Deuxièmement, s''ils sont bien gérés, ces distributeurs peuvent offrir une gamme de boissons saines, comme de l''eau, du jus de fruits pur et des boissons aux fruits sans sucre ajouté. Ces distributeurs peuvent être une source de revenus supplémentaire pour l''école, qui peut être réinvestie dans l''amélioration des infrastructures ou des programmes scolaires. »',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_335',
  'Thème du débat : « Rôle De La Télévision Dans L''éducation Des Enfants. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Écrivez dans un article un message pour raconter votre arrivée dans un pays étranger en donnant vos impressions.

Document B :
La télévision est un outil de communication et de divertissement largement répandu dans notre société moderne. Son influence est incontestable, tant sur les individus que sur la culture en général. Elle permet de diffuser des informations, d''offrir des divertissements variés et de favoriser la diffusion de la culture. La télévision est présente dans de nombreux foyers et constitue une source d''information et de divertissement accessibles à tous. Grâce à sa portée et à sa capacité à toucher un large public, la télévision joue un rôle important dans la transmission des connaissances et la sensibilisation aux enjeux sociaux.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_336',
  'Thème du débat : « L''interdiction des voitures en ville. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez passé des vacances au Canada par le biais d’une agence. Écrivez en commentaire l''expérience que vous avez vécue durant ce voyage.

Document B :
Le dernier exemple vient d''Oslo, la capitale norvégienne. Une responsable du projet annonce: « Ce sera mieux pour les piétons, les cyclistes, les commerces. Mieux pour tout le monde ». Moins de voitures, c''est la reconquête de la ville par ses habitants. Les bénéfices pour la qualité de l''air et pour l''économie locale seront garantis.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_337',
  'Thème du débat : « Restauration Rapide. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez effectué un voyage qui s''est mal passé par le biais d''une agence. Ecrivez leur un courriel pour exprimer votre mécontentement.

Document B :
Les restaurants rapides proposent des plats équilibrés et variés et ils respectent les normes d''hygiène et les variétés de produits qui sont bonnes et c''est le client qui compose son menu donc il est responsable.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_338',
  'Thème du débat : « Animaux De Compagnie. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Raconte ton expérience de bénévolat dans une association pour les personnes âgées.

Document B :
La question des animaux de compagnie dans les locations de courte durée suscite souvent des débats. Certains propriétaires sont ouverts à accueillir des animaux, tandis que d''autres les interdisent. Pour les amoureux des animaux, il est crucial de trouver des logements qui acceptent les animaux de compagnie, car ils considèrent leurs compagnons à fourrure comme des membres de leur famille. Ces voyageurs ont besoin de logements où leurs animaux peuvent se sentir à l''aise et bienvenus, avec des espaces extérieurs appropriés pour les promenades et les jeux.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_339',
  'Thème du débat : « Vie en colocation entre adultes. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez visité une ville que vous ne connaissiez pas. Vous avez envie de partager votre découverte. Vous postez un message sur un site Internet dédié aux voyages. Racontez votre expérience et expliquez ce qui vous a plu et ce qui vous a déplu dans la ville.

Document B :
Vivre avec d''autres personnes demande d''avoir une bonne entente et de respecter certaines règles. Il n''est pas toujours possible d''écouter sa musique préférée à volume élevé, d''inviter tous ses amis pour faire la fête ou de laisser de la vaisselle sale dans la cuisine. Chaque individu a des habitudes susceptibles d''irriter les autres. C''est pourquoi il est essentiel d''établir des règles de vie en communauté et de les respecter mutuellement. Il est important de communiquer avec ses colocataires chaque fois qu''un problème survient. L''organisation et la discussion sont les clés d''une colocation réussie ou non.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_340',
  'Thème du débat : « Le travail des étudiants pendant les vacances: Pour ou contre ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Vous avez participé à un concours de cuisine, vous allez décrire vos souvenirs dans votre blog en indiquant les détails.

Document B :
Opinion 1 : Alexandre, un conseiller d''orientation',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_341',
  'Thème du débat : « le travail : Favorable ou défavorable ? »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
« Je suis contre l''idée que les jeunes doivent travailler pendant leurs vacances. Les adolescents sont déjà sous une énorme pression pendant l''année scolaire avec les études, les examens et les activités parascolaires. Les vacances doivent être une période pour eux de se détendre, de se décompresser et de poursuivre des intérêts personnels. Les forcer à travailler pourrait contribuer au stress et à l''épuisement. Il est également important pour les jeunes de disposer de temps non structuré pour explorer leur créativité, passer du temps avec leurs amis et leur famille, et tout simplement être des enfants. Le travail peut attendre. »

Document B :
écrivez un message à votre ami(e) pour l''inviter à venir passer le week-end prochain avec vous en indiquant (activités, lieu, etc.).',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_342',
  'Thème du débat : « Prise de position / Débat »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
« Je suis convaincu que le travail est absolument favorable pour l''individu et la société. Le travail permet non seulement d''assurer son propre moyen de subsistance, mais également de contribuer au développement économique de la société. De plus, il favorise l''autonomie et la confiance en soi, encourage le sens des responsabilités et offre une opportunité d''épanouissement personnel et professionnel. Il peut même aider à forger notre identité et notre place dans la société. »

Document B :
Opinion 2 : Laura, sociologue',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_343',
  'Thème du débat : « L''interdiction des voitures en ville. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Le dernier exemple vient d''Oslo, la capitale norvégienne. Une responsable du projet annonce: « Ce sera mieux pour les piétons, les cyclistes, les commerces. Mieux pour tout le monde ». Moins de voitures, c''est la reconquête de la ville par ses habitants. Les bénéfices pour la qualité de l''air et pour l''économie locale seront garantis.

Document B :
Il faut réfléchir avant d''interdire les voitures en ville. II est vrai que l''idée d''une ville sans circulation et beaucoup moins polluée est tentante. Mais la réalisation de cette idée coûte cher. De plus, où se gareront les voitures interdites de circulation au centre-ville? II faut aussi bien préciser que les véhicules professionnels que conduisent les policiers, les pompiers, les ambulanciers, les livreurs auront le droit de circuler. Enfin, pour que les habitants puissent se déplacer facilement il faut développer les transports en commun.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_344',
  'Thème du débat : « Animaux De Compagnie. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
La question des animaux de compagnie dans les locations de courte durée suscite souvent des débats. Certains propriétaires sont ouverts à accueillir des animaux, tandis que d''autres les interdisent. Pour les amoureux des animaux, il est crucial de trouver des logements qui acceptent les animaux de compagnie, car ils considèrent leurs compagnons à fourrure comme des membres de leur famille. Ces voyageurs ont besoin de logements où leurs animaux peuvent se sentir à l''aise et bienvenus, avec des espaces extérieurs appropriés pour les promenades et les jeux.

Document B :
La présence d''animaux de compagnie dans les locations de courte durée peut également présenter des défis pour les propriétaires et les autres voyageurs. Certains animaux peuvent être bruyants, causer des dégâts ou provoquer des allergies chez certaines personnes. En raison de ces préoccupations, de nombreux propriétaires préfèrent interdire les animaux de compagnie dans leurs logements. Cela peut limiter les options pour les voyageurs qui souhaitent emmener leurs animaux avec eux. Cependant, il existe également des logements de courte durée spécialement conçus pour les animaux de compagnie, offrant des équipements adaptés tels que des litières, des jouets et des espaces dédiés pour les animaux. Ces logements sont souvent très demandés par les voyageurs qui veulent profiter de leurs vacances en compagnie de leurs animaux bien-aimés.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_345',
  'Thème du débat : « Location Courte Durée. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Écrivez un courriel à votre ami pour l''inviter à vous accompagner au concert de votre musicien préféré en lui précisant tous les détails (heure, tarif, lieu&#8230;)

Document B :
La location courte durée offre flexibilité et commodité pour les voyageurs. Elle permet de louer un logement pour une période de temps limitée, que ce soit pour des vacances ou un déplacement professionnel. Cela permet aux voyageurs de profiter d''un hébergement confortable avec des équipements adaptés à leurs besoins, tout en évitant les engagements à long terme.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_346',
  'Thème du débat : « Objets Connectés »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Écrivez un thème ou un article sur votre artiste préféré.

Document B :
Les objectés connectés permettent de vérifier à travers un téléphone si un individu est en bonne santé tout en vérifiant ses battements de cœur et le nombre de pas qu''il effectue. Ils facilitent également le travail humain. Plus besoin d''un portier désormais, vous pouvez ouvrir un portail à domicile à l''aide des appareils connectés à votre téléphone portable. Il est également possible de faire surveiller son domicile à distance.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_347',
  'Thème du débat : « Égalité Entre Hommes Et Femmes. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Écrivez un courriel à vos amis pour leur parler de votre première semaine au travail dans votre nouveau poste.

Document B :
Certains postes sont majoritairement occupés par des hommes. Au Québec, l''égalité entre les femmes et les hommes est respectée, les femmes peuvent les métiers réservés aux hommes tels que les postes de direction.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_348',
  'Thème du débat : « Gratuité Des Transports En Commun. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
D''après https://www.village-justice.com

Document B :
Vous avez effectué un travail temporaire en été. Vous écrivez un message à vos amis pour leur raconter ce que vous avez fait.',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_349',
  'Thème du débat : « Vêtements De Grande Marque. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
L''idée n''est pas bonne. D''une part, cela couterait cher aux villes. Or, il me semble que la ville de Toulouse a d''autres problèmes à régler en priorité. Par exemple, il faudrait d''abord réaménager leurs espaces verts, cela profiterait à tout le monde. D''autre part, il vaudrait mieux réorganiser les transports publics au lieu de les rendre gratuits. Aujourd''hui, les gens préfèrent prendre leur voiture parce que la ville manque de transports publics dans certains quartiers éloignés. Et puis, selon moi, il faut garder les transports publics payants. Les gens respecteront davantage les équipements s''ils participent à leur financement en payant un titre de transport.

Document B :
Répondre au courriel de votre ami Lucas pour lui donner les informations sur les nouveaux locaux de votre entreprise (lieu, disposition des pièces, équipements&#8230;)',
  NULL,
  true
),
(
  'expression_ecrite',
  3,
  'EE_T3_350',
  'Thème du débat : « Restauration Rapide. »

• Première partie, présentez les deux opinions avec vos propres mots (entre 40 et 60 mots) ;
• Deuxième partie, donnez votre position sur le thème général, commun à ces deux opinions (entre 80 et 120 mots).

Document A :
Afin de participer à un concours sur internet, racontez à propos d''une fête qui vous a marqué le plus (anniversaire, fête traditionnelle&#8230;)

Document B :
La lecture pour les enfants est d''une importance capitale dans leur développement. Elle favorise l''acquisition du langage, stimule leur imagination et leur créativité, et contribue à développer leur concentration et leurs compétences cognitives. La lecture offre également aux enfants une ouverture sur le monde qui les entoure, en leur permettant de découvrir de nouveaux univers, des personnages fascinants et des histoires captivantes. Les livres adaptés à leur âge les accompagnent dans leur apprentissage et les aident à comprendre le monde qui les entoure de manière ludique et éducative.',
  NULL,
  true
);

