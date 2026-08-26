
-- Insert sample tâches for expression écrite
INSERT INTO public.taches (epreuve, numero_tache, consigne, actif) VALUES
('expression_ecrite', 1, 'Rédigez un courriel à un ami pour lui présenter votre nouveau logement au Canada. Décrivez le quartier, les transports disponibles et ce que vous appréciez dans votre nouvel environnement. (Environ 60-80 mots)', true),
('expression_ecrite', 2, 'Vous souhaitez vous inscrire à un club de sport dans votre ville. Rédigez un courriel au responsable pour vous présenter, expliquer vos motivations et demander des informations sur les modalités d''inscription. (Environ 80-100 mots)', true),
('expression_ecrite', 3, 'Vous avez lu un article sur les avantages et inconvénients du télétravail. Rédigez un texte dans lequel vous donnez votre opinion sur ce sujet en vous appuyant sur des exemples concrets. (Environ 120-150 mots)', true);

-- Insert sample tâches for expression orale
INSERT INTO public.taches (epreuve, numero_tache, consigne, duree_secondes, actif) VALUES
('expression_orale', 1, 'Parlez de votre expérience dans l''apprentissage du français. Quelles méthodes utilisez-vous ? Quelles sont vos difficultés et vos succès ? Donnez des exemples précis de votre parcours.', 120, true),
('expression_orale', 3, 'Vous devez présenter les avantages et les inconvénients de vivre dans une grande ville au Canada (comme Montréal ou Toronto) par rapport à une ville moyenne. Développez votre argumentation en donnant des exemples concrets tirés de la réalité canadienne ou de votre expérience personnelle.', 270, true);

-- Insert sample questions for comprehension_ecrit
INSERT INTO public.questions (epreuve, niveau, texte, choix, bonne_reponse, explication, ordre) VALUES
('comprehension_ecrit', 'B1', 
'Lisez le texte suivant et répondez à la question.

Le système de santé canadien, souvent appelé Medicare, est un système de soins de santé financé par l''État qui offre une couverture universelle à tous les résidents canadiens. Chaque province et territoire administre son propre régime d''assurance-maladie, mais tous respectent les principes fondamentaux établis par la Loi canadienne sur la santé : accessibilité, universalité, transférabilité, intégralité et administration publique.

Question : Selon le texte, qui administre les régimes d''assurance-maladie au Canada ?',
'[{"id":"A","texte":"Le gouvernement fédéral"},{"id":"B","texte":"Chaque province et territoire"},{"id":"C","texte":"Des compagnies d''assurance privées"},{"id":"D","texte":"Les hôpitaux locaux"}]',
'B',
'Le texte indique clairement que "chaque province et territoire administre son propre régime d''assurance-maladie".',
1),

('comprehension_ecrit', 'B2',
'Lisez le texte suivant et répondez à la question.

L''immigration au Canada est gérée par le système d''Entrée express, un système de gestion des demandes d''immigration économique. Les candidats reçoivent un score basé sur des facteurs tels que l''âge, le niveau d''éducation, l''expérience professionnelle et les compétences linguistiques. Les candidats ayant les scores les plus élevés reçoivent une invitation à présenter une demande de résidence permanente.

Question : Quel facteur N''est PAS mentionné comme critère d''évaluation dans le système d''Entrée express ?',
'[{"id":"A","texte":"L''âge du candidat"},{"id":"B","texte":"Le niveau d''éducation"},{"id":"C","texte":"Le pays d''origine"},{"id":"D","texte":"L''expérience professionnelle"}]',
'C',
'Le texte mentionne l''âge, le niveau d''éducation, l''expérience professionnelle et les compétences linguistiques, mais pas le pays d''origine.',
2),

('comprehension_ecrit', 'B1',
'Lisez le texte suivant et répondez à la question.

Montréal est la deuxième plus grande ville du Canada et la métropole de la province de Québec. C''est une ville bilingue où le français est la langue officielle, mais où l''anglais est largement parlé. La ville est reconnue pour sa vie culturelle intense, ses nombreux festivals internationaux et sa scène gastronomique diversifiée.

Question : Quelle est la langue officielle de Montréal selon le texte ?',
'[{"id":"A","texte":"L''anglais"},{"id":"B","texte":"Le français"},{"id":"C","texte":"Le français et l''anglais"},{"id":"D","texte":"Ni l''un ni l''autre"}]',
'B',
'Le texte précise que "le français est la langue officielle" de Montréal.',
3);

-- Insert sample questions for comprehension_oral
INSERT INTO public.questions (epreuve, niveau, texte, choix, bonne_reponse, explication, ordre) VALUES
('comprehension_oral', 'B1',
'Écoutez l''enregistrement et répondez à la question.

[Audio: Une femme parle de ses habitudes de transport à Montréal]
"Je prends le métro tous les matins pour aller au travail. C''est rapide et ça évite les embouteillages. Parfois, quand il fait beau, je préfère prendre mon vélo. C''est bon pour la santé et pour l''environnement."

Question : Quel moyen de transport cette femme utilise-t-elle le plus souvent ?',
'[{"id":"A","texte":"La voiture"},{"id":"B","texte":"Le bus"},{"id":"C","texte":"Le métro"},{"id":"D","texte":"Le vélo"}]',
'C',
'La femme dit qu''elle prend "le métro tous les matins pour aller au travail", indiquant que c''est son moyen de transport quotidien habituel.',
1);
