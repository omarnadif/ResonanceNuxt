-- ─────────────────────────────────────────────────────────────
-- RESONANCE — Seed data (profiles + announcements)
-- Coller dans Supabase SQL Editor et exécuter
-- ─────────────────────────────────────────────────────────────

-- ── PROFILES ──────────────────────────────────────────────────

INSERT INTO profiles (id, first_name, last_name, stage_name, bio, city, created_date)
VALUES
  ('d08e9c26-7247-41a6-bb90-5a587f1e96a2','Lucas','Martin','LukeM','Guitariste rock depuis 10 ans. Passionné par le son vintage des années 70-80. Expérience live dans plusieurs salles parisiennes.','Paris',CURRENT_DATE - 30),
  ('e1acf4ec-d1a5-4954-811e-3c62c30d7055','Emma','Bernard',NULL,'Batteuse metal/jazz-fusion, diplômée du conservatoire. Ouverte à tous les styles, technique solide et lecture de partitions.','Lyon',CURRENT_DATE - 28),
  ('71873965-33e3-4b35-bb3c-5ac87efdd813','Thomas','Dubois','T-Bass','Bassiste jazz et funk depuis 8 ans. Slap, fingerstyle, expérience live et studio. À la recherche de nouveaux projets.','Marseille',CURRENT_DATE - 27),
  ('373a58bc-1a5f-4b43-aea1-c62b6e05a9ad','Chloé','Roux',NULL,'Pianiste classique reconvertie au jazz. Harmonie avancée, accompagnement et improvisation. Donne aussi des cours.','Paris',CURRENT_DATE - 25),
  ('3366b134-00dc-48a2-b260-d2c9940005cf','Alexandre','Petit','AlexBlues','Guitariste blues depuis 15 ans. Influences Stevie Ray Vaughan et BB King. J''ai tourné en Europe avec deux groupes.','Bordeaux',CURRENT_DATE - 24),
  ('d6706aca-ac5d-42f1-a1c4-5d8a130bb04c','Camille','Girard','Camille G.','Chanteuse pop/soul avec 6 ans de scène. Voix chaleureuse, bilingue FR/EN. Cherche formation sérieuse ou projets studio.','Toulouse',CURRENT_DATE - 22),
  ('7ab9da7a-0607-4ea3-a2e5-4e32ff814556','Nicolas','Robert','NicoSax','Saxophoniste jazz certifié. Alto et ténor. Disponible pour concerts, sessions enregistrement et jam sessions.','Nantes',CURRENT_DATE - 21),
  ('1ffefc11-4f32-4fd5-a021-b2836544cafc','Mia','Laurent',NULL,'Violoniste classique et folk. Conservatoire de Strasbourg. Projets musique du monde et compositions originales.','Strasbourg',CURRENT_DATE - 20),
  ('ed8feb10-e58a-420f-a1d4-5f7f1b73fe62','Baptiste','Mercier','B-Metal','Guitariste metal/djent. Technique pointue, fan de Periphery et Meshuggah. Setup 7-cordes + pédalboard complet.','Lille',CURRENT_DATE - 19),
  ('04e33196-b38d-4a98-a4d9-fafe3d017132','Sarah','Fontaine','SarahF','Bassiste rock/alternative depuis 7 ans. Expérience live dans des salles 200-500 personnes. Sérieuse et motivée.','Paris',CURRENT_DATE - 18),
  ('4c689705-a2c8-437e-8eb3-16f0fcc3d9fa','Julien','Moreau','JuFunk','Batteur funk/soul, groove et précision avant tout. Disponible pour répétitions, enregistrements et tournées courtes.','Lyon',CURRENT_DATE - 17),
  ('dfd5f786-5eb5-4fb2-8907-daf58be67e9e','Léa','Simon',NULL,'Pianiste jazz, passionnée de standards. Harmonie, improvisation et accompagnement. Cherche quartet ou trio.','Rennes',CURRENT_DATE - 16),
  ('0d7a32d4-5225-47b6-907c-d6ce74ee76ec','Antoine','Lefebvre','Tony Folk','Guitariste et compositeur folk/acoustique. Influences Sufjan Stevens et Nick Drake. Album en préparation.','Montpellier',CURRENT_DATE - 15),
  ('793a0d58-020f-4c50-9ae3-deb1910e025d','Yasmine','Dupont','Yazz','Chanteuse R&B/soul avec un timbre chaud et expressif. Influences Amy Winehouse. Cherche producteur ou groupe solide.','Paris',CURRENT_DATE - 14),
  ('5e249273-69ab-4a11-aae2-4845f142ec56','Maxime','Hubert','MaxLow','Bassiste électronique, dub et trip-hop. Production et jeu en direct, setup laptop + basse. Niçois expatrié.','Nice',CURRENT_DATE - 13),
  ('9e96f766-bade-496e-91fd-937989186da4','Clara','Blanc',NULL,'Guitariste indie/shoegaze. Fan de Slowdive et My Bloody Valentine. Cherche groupe pour créer quelque chose de beau.','Bordeaux',CURRENT_DATE - 12),
  ('6fdbceab-3424-4f0f-9b76-183a83f306d4','Théo','Garnier','T-Jazz','Batteur jazz manouche et be-bop. Précision métronomique, écoute active. Disponible pour concerts et ateliers.','Nantes',CURRENT_DATE - 11),
  ('515bb1de-0350-476e-a441-bf2a0810cef4','Inès','Faure','Inès Soul','Chanteuse soul/gospel. Chœurs et voix principale. Formation gospel à Toulouse, 4 ans de scène.','Lyon',CURRENT_DATE - 10),
  ('abe48360-3928-43f2-b407-b029f74ce743','Hugo','Marchand','HugoRock','Guitariste rock alternatif autodidacte depuis 12 ans. Compositions personnelles disponibles à l''écoute.','Paris',CURRENT_DATE - 9),
  ('13163926-1db8-4201-af24-255cfb649a28','Marine','Rousseau',NULL,'Pianiste et accordéoniste. Musique française, variété et chanson. Professeure expérimentée, tous niveaux.','Toulouse',CURRENT_DATE - 8),
  ('88d567ad-d353-4d2f-b73b-d529f641b951','Raphaël','Colin','Raph_Metal','Bassiste metal/prog. Slap, tapping, basse 5 cordes. Technique avancée, cherche groupe ambitieux.','Marseille',CURRENT_DATE - 7),
  ('ec502bed-56af-432e-8bc2-5373bd5ba481','Noémie','Gros',NULL,'Violoniste folk et celtique. Créatrice d''un groupe de musique traditionnelle à Strasbourg.','Strasbourg',CURRENT_DATE - 6),
  ('ba4a800b-9d03-423d-bb74-31d14e9109f3','Pierre','Lambert','P-Blues','Guitariste et harmoniciste blues. Influences BB King et Robert Johnson. 20 ans de pratique.','Bordeaux',CURRENT_DATE - 5),
  ('f0bf9717-766b-4d1c-b356-d178836275c3','Axelle','Brunet','Axelle B.','Chanteuse jazz et bossa nova. Bilingue FR/EN/PT. Expérience bars, festivals et mariages haut de gamme.','Paris',CURRENT_DATE - 4),
  ('a4ae62f1-7143-449d-991a-c9bb4c762aae','Kevin','Denis','K-Drums','Batteur rock/metal. Double pédale maîtrisée, lecture de partitions. Sérieux et ponctuel.','Lille',CURRENT_DATE - 3),
  ('b33e48a5-8725-425f-a1da-321fe1bc2988','Morgane','Perrin',NULL,'Pianiste indie/électro. Mélange synthétiseurs vintage et piano acoustique. Cherche collab créatif et original.','Rennes',CURRENT_DATE - 2),
  ('070274f4-141b-4bf5-98a0-0d2947a899bb','Florian','Leroy','Flo_Shred','Guitariste metal/shred. Sweep picking, legato, technique avancée. Propose aussi des cours pour guitaristes.','Nice',CURRENT_DATE - 1),
  ('2147b0d0-256d-4e31-affa-e0faed9837e9','Pauline','Moulin','PauloFunk','Bassiste funk/groove. Influences Victor Wooten et Bootsy Collins. Toujours partante pour groover fort.','Paris',CURRENT_DATE),
  ('038ecc3d-e464-49bc-9217-32f179e15a50','Adrien','Barbier','Adri_Sax','Saxophoniste et clarinettiste. Jazz, soul, funk. Disponible pour concerts privés, mariages et festivals.','Lyon',CURRENT_DATE)
ON CONFLICT (id) DO NOTHING;


-- ── ANNOUNCEMENTS ─────────────────────────────────────────────

INSERT INTO announcements (id_profile, title, description, type, instrument, genre, location, price, price_type, status_announcements, created_date)
VALUES

-- Lucas — guitariste rock Paris
('d08e9c26-7247-41a6-bb90-5a587f1e96a2',
 'Guitariste rock cherche groupe Paris',
 'Je suis guitariste lead avec 10 ans de pratique, influences 70s/80s. Cherche un groupe rock établi ou en cours de formation sur Paris. Disponible les week-ends et certains soirs. Matériel pro, transport assuré.',
 'Musicien cherche groupe','Guitare','Rock','Paris',NULL,NULL,'published',CURRENT_DATE - 5),

('d08e9c26-7247-41a6-bb90-5a587f1e96a2',
 'Recherche collab studio guitare/compo',
 'Je cherche un compositeur ou un chanteur pour créer des titres ensemble en studio. J''ai accès à un studio home. Influences rock moderne et cinématographique.',
 'Collaboration studio','Guitare','Rock','Paris',NULL,NULL,'published',CURRENT_DATE - 2),

-- Emma — batteuse metal Lyon
('e1acf4ec-d1a5-4954-811e-3c62c30d7055',
 'Batteuse cherche groupe metal/fusion Lyon',
 'Diplômée du conservatoire de Lyon, je joue metal progressif et jazz-fusion depuis 6 ans. Cherche groupe sérieux pour répétitions régulières et projets de concerts. Double pédale, kit complet.',
 'Musicien cherche groupe','Batterie','Metal','Lyon',NULL,NULL,'published',CURRENT_DATE - 8),

('e1acf4ec-d1a5-4954-811e-3c62c30d7055',
 'Cours de batterie tous niveaux — Lyon',
 'Professeure de batterie diplômée, j''enseigne depuis 3 ans. Cours adaptés à tous les niveaux, du débutant au confirmé. Méthode progressive et fun. Studio équipé à disposition.',
 'Cours de musique','Batterie','Tous genres','Lyon',35,'heure','published',CURRENT_DATE - 3),

-- Thomas — bassiste jazz Marseille
('71873965-33e3-4b35-bb3c-5ac87efdd813',
 'Bassiste jazz/funk cherche formation Marseille',
 'Bassiste avec 8 ans d''expérience, à l''aise sur le jazz, le funk et la soul. Je lis les partitions et je maîtrise le slap. Cherche un groupe ou quartet pour jouer régulièrement.',
 'Musicien cherche groupe','Basse','Jazz','Marseille',NULL,NULL,'published',CURRENT_DATE - 12),

('71873965-33e3-4b35-bb3c-5ac87efdd813',
 'Disponible pour session basse en studio',
 'Bassiste confirmé disponible pour des sessions d''enregistrement. Styles : jazz, funk, soul, R&B. Tarif négociable selon le projet. Disponible en semaine.',
 'Collaboration studio','Basse','Jazz','Marseille',80,'séance','published',CURRENT_DATE - 6),

-- Chloé — pianiste Paris
('373a58bc-1a5f-4b43-aea1-c62b6e05a9ad',
 'Cours de piano jazz et classique — Paris',
 'Pianiste diplômée, j''enseigne le piano classique et le jazz. Solfège, technique, harmonie. Cours à domicile sur Paris et région parisienne. Tous âges, tous niveaux.',
 'Cours de musique','Piano','Jazz','Paris',40,'heure','published',CURRENT_DATE - 10),

('373a58bc-1a5f-4b43-aea1-c62b6e05a9ad',
 'Pianiste cherche trio jazz ou quartet',
 'Je cherche un contrebassiste, un batteur et éventuellement un souffleur pour former un quartet jazz. Répertoire standards + compositions. Ambiance détendue mais travail sérieux.',
 'Musicien cherche groupe','Piano','Jazz','Paris',NULL,NULL,'published',CURRENT_DATE - 4),

-- Alexandre — guitariste blues Bordeaux
('3366b134-00dc-48a2-b260-d2c9940005cf',
 'Guitariste blues cherche backing band Bordeaux',
 'Après 15 ans de guitare et des tournées européennes, je recherche un batteur, un bassiste et un claviériste pour monter un projet blues/rock. Scène locale prioritaire.',
 'Musicien cherche groupe','Guitare','Blues','Bordeaux',NULL,NULL,'published',CURRENT_DATE - 7),

('3366b134-00dc-48a2-b260-d2c9940005cf',
 'Cours de guitare blues et rock — Bordeaux',
 'Je propose des cours de guitare axés blues, rock et improvisation. Technique, théorie, feeling. Débutants et intermédiaires bienvenus. À domicile ou chez moi.',
 'Cours de musique','Guitare','Blues','Bordeaux',30,'heure','published',CURRENT_DATE - 1),

-- Camille — chanteuse Toulouse
('d6706aca-ac5d-42f1-a1c4-5d8a130bb04c',
 'Chanteuse pop/soul cherche groupe Toulouse',
 'Chanteuse avec 6 ans de scène cherche groupe pop, soul ou R&B. Je suis sérieuse, ponctuelle et passionnée. Voix formée, expérience des festivals locaux. Dispo week-ends.',
 'Musicien cherche groupe','Chant','Pop','Toulouse',NULL,NULL,'published',CURRENT_DATE - 6),

('d6706aca-ac5d-42f1-a1c4-5d8a130bb04c',
 'Prestation chant pour événement / mariage',
 'Chanteuse disponible pour mariages, anniversaires et événements privés. Répertoire varié : pop française, soul, variété internationale. Devis sur demande.',
 'Concert / Événement','Chant','Pop','Toulouse',300,'concert','published',CURRENT_DATE - 2),

-- Nicolas — saxophoniste Nantes
('7ab9da7a-0607-4ea3-a2e5-4e32ff814556',
 'Saxophoniste disponible pour concerts et sessions',
 'Sax alto et ténor, style jazz/soul. Disponible pour renforcer un groupe sur scène ou en studio. Lecture rapide, adaptable. Cachet négociable.',
 'Concert / Événement','Saxophone','Jazz','Nantes',150,'concert','published',CURRENT_DATE - 9),

('7ab9da7a-0607-4ea3-a2e5-4e32ff814556',
 'Groupe jazz cherche guitariste manouche Nantes',
 'Notre quartet jazz recherche un guitariste manouche pour compléter notre formation. Nous jouons des standards et quelques compositions originales. Répètes le jeudi soir.',
 'Groupe cherche musicien','Guitare','Jazz','Nantes',NULL,NULL,'published',CURRENT_DATE - 4),

-- Mia — violoniste Strasbourg
('1ffefc11-4f32-4fd5-a021-b2836544cafc',
 'Violoniste cherche projet folk/world Strasbourg',
 'Violoniste classique et folk à la recherche d''un projet musique du monde ou folk contemporain. Compositions originales bienvenues. Je suis flexible et créative.',
 'Musicien cherche groupe','Violon','Folk','Strasbourg',NULL,NULL,'published',CURRENT_DATE - 11),

('1ffefc11-4f32-4fd5-a021-b2836544cafc',
 'Cours de violon classique et folk — Strasbourg',
 'J''enseigne le violon classique et les styles folk/celtique. Enfants et adultes. Méthode personnalisée. Disponible en soirée et week-end.',
 'Cours de musique','Violon','Classique','Strasbourg',35,'heure','published',CURRENT_DATE - 5),

-- Baptiste — guitariste metal Lille
('ed8feb10-e58a-420f-a1d4-5f7f1b73fe62',
 'Groupe metal progressif cherche guitariste soliste Lille',
 'Groupe de metal progressif (djent/prog) bien établi à Lille cherche second guitariste pour les soli et les arrangements. Niveau avancé requis. Matériel pro obligatoire.',
 'Groupe cherche musicien','Guitare','Metal','Lille',NULL,NULL,'published',CURRENT_DATE - 14),

('ed8feb10-e58a-420f-a1d4-5f7f1b73fe62',
 'Collab studio metal / enregistrement démo',
 'Je cherche un chanteur ou une chanteuse metal pour enregistrer une démo 3 titres dans mon studio home. Projet sérieux, prod soignée. Partage des droits 50/50.',
 'Collaboration studio','Guitare','Metal','Lille',NULL,NULL,'published',CURRENT_DATE - 3),

-- Sarah — bassiste rock Paris
('04e33196-b38d-4a98-a4d9-fafe3d017132',
 'Bassiste rock cherche groupe Paris',
 'Bassiste avec 7 ans d''expérience live, je cherche un groupe rock/alternatif sérieux sur Paris. Habituée des salles moyennes. Je lis les partitions et j''apprends vite.',
 'Musicien cherche groupe','Basse','Rock','Paris',NULL,NULL,'published',CURRENT_DATE - 7),

-- Julien — batteur funk Lyon
('4c689705-a2c8-437e-8eb3-16f0fcc3d9fa',
 'Batteur funk cherche formation soul/funk Lyon',
 'Je cherche un groupe funk ou soul à Lyon pour jouer régulièrement. Influences James Brown, Tower of Power. Sérieux et motivé, kit Ludwig disponible.',
 'Musicien cherche groupe','Batterie','Funk','Lyon',NULL,NULL,'published',CURRENT_DATE - 6),

('4c689705-a2c8-437e-8eb3-16f0fcc3d9fa',
 'Groupe funk cherche claviériste Hammond à Lyon',
 'Notre groupe funk de 4 musiciens cherche un claviériste ou organiste pour compléter le line-up. Répètes le samedi après-midi. Esprit collectif, pas d''ego.',
 'Groupe cherche musicien','Claviers','Funk','Lyon',NULL,NULL,'published',CURRENT_DATE - 2),

-- Léa — pianiste jazz Rennes
('dfd5f786-5eb5-4fb2-8907-daf58be67e9e',
 'Formation trio jazz cherche contrebassiste Rennes',
 'Piano + batterie cherchons contrebassiste pour compléter notre trio jazz. Répertoire standards + quelques compositions. Ambiance sérieuse mais conviviale. Répètes hebdo.',
 'Groupe cherche musicien','Contrebasse','Jazz','Rennes',NULL,NULL,'published',CURRENT_DATE - 9),

-- Antoine — guitariste folk Montpellier
('0d7a32d4-5225-47b6-907c-d6ce74ee76ec',
 'Guitariste folk cherche chanteur/chanteuse Montpellier',
 'Je compose des morceaux folk/acoustic depuis 5 ans. Je cherche un chanteur ou une chanteuse pour donner vie à ces compositions. Projet d''album prévu. Ambiance créative.',
 'Musicien cherche groupe','Guitare acoustique','Folk','Montpellier',NULL,NULL,'published',CURRENT_DATE - 8),

('0d7a32d4-5225-47b6-907c-d6ce74ee76ec',
 'Concert acoustique folk — disponible pour dates',
 'Guitariste folk disponible pour concerts acoustiques, cafés-concerts, festivals. Répertoire solo + duo possible. Ambiance intimiste garantie.',
 'Concert / Événement','Guitare acoustique','Folk','Montpellier',100,'concert','published',CURRENT_DATE - 2),

-- Yasmine — chanteuse R&B Paris
('793a0d58-020f-4c50-9ae3-deb1910e025d',
 'Chanteuse R&B cherche producteur ou beatmaker',
 'Je suis chanteuse R&B/soul avec une voix formée et du contenu. Je cherche un producteur ou beatmaker pour finaliser un EP 5 titres. Projet sérieux, budget prévu.',
 'Collaboration studio','Chant','R&B','Paris',NULL,NULL,'published',CURRENT_DATE - 5),

('793a0d58-020f-4c50-9ae3-deb1910e025d',
 'Groupe R&B/soul cherche chanteuse principale — Paris',
 'Notre groupe soul de 5 musiciens cherche une chanteuse principale pour scène et studio. Nous avons déjà des engagements confirmés. Niveau et implication exigés.',
 'Groupe cherche musicien','Chant','R&B','Paris',NULL,NULL,'published',CURRENT_DATE - 1),

-- Maxime — bassiste électronique Nice
('5e249273-69ab-4a11-aae2-4845f142ec56',
 'Collab musique électronique / dub — Nice',
 'Bassiste + producteur cherche un DJ ou un beatmaker pour créer un projet dub/trip-hop. J''apporte la basse live et des arrangements. Fusion électronique/acoustique.',
 'Collaboration studio','Basse','Électronique','Nice',NULL,NULL,'published',CURRENT_DATE - 10),

-- Clara — guitariste indie Bordeaux
('9e96f766-bade-496e-91fd-937989186da4',
 'Groupe indie/shoegaze cherche batteur Bordeaux',
 'Notre duo guitariste/chanteur cherche un batteur pour former un groupe shoegaze/dream pop. Influences Slowdive, Ride, Beach House. Démos disponibles à l''écoute.',
 'Groupe cherche musicien','Batterie','Indie','Bordeaux',NULL,NULL,'published',CURRENT_DATE - 7),

-- Théo — batteur jazz Nantes
('6fdbceab-3424-4f0f-9b76-183a83f306d4',
 'Batteur jazz manouche disponible concerts Nantes',
 'Spécialiste du jazz manouche et du be-bop. Je cherche des groupes ou des formations pour des concerts ponctuels. Je lis les charts, bonne réactivité, bon son.',
 'Concert / Événement','Batterie','Jazz','Nantes',120,'concert','published',CURRENT_DATE - 4),

-- Inès — chanteuse soul Lyon
('515bb1de-0350-476e-a441-bf2a0810cef4',
 'Chanteuse soul/gospel cherche groupe Lyon',
 'Voix formée au gospel, 4 ans de scène, je cherche un groupe soul ou funk à Lyon pour des projets réguliers. Enregistrement et concerts. Très motivée.',
 'Musicien cherche groupe','Chant','Soul','Lyon',NULL,NULL,'published',CURRENT_DATE - 6),

('515bb1de-0350-476e-a441-bf2a0810cef4',
 'Cours de chant soul et technique vocale — Lyon',
 'Je propose des cours de chant axés soul, gospel et technique vocale. Travail du souffle, de la tessiture et du feeling. Débutants et intermédiaires.',
 'Cours de musique','Chant','Soul','Lyon',40,'heure','published',CURRENT_DATE - 1),

-- Hugo — guitariste rock Paris
('abe48360-3928-43f2-b407-b029f74ce743',
 'Projet rock alternatif cherche membres Paris',
 'Je monte un groupe rock alternatif sur Paris. J''ai des compositions et un local de répète. Cherche batteur, bassiste et éventuellement un deuxième guitariste. Niveau intermédiaire à avancé.',
 'Groupe cherche musicien','Tous instruments','Rock','Paris',NULL,NULL,'published',CURRENT_DATE - 8),

-- Marine — pianiste accordéoniste Toulouse
('13163926-1db8-4201-af24-255cfb649a28',
 'Cours de piano débutants et intermédiaires — Toulouse',
 'Pianiste et accordéoniste expérimentée, j''enseigne depuis 8 ans. Cours de piano à domicile sur Toulouse, enfants dès 5 ans et adultes. Méthode douce et efficace.',
 'Cours de musique','Piano','Tous genres','Toulouse',35,'heure','published',CURRENT_DATE - 3),

-- Raphaël — bassiste metal Marseille
('88d567ad-d353-4d2f-b73b-d529f641b951',
 'Bassiste metal prog cherche groupe Marseille',
 'Bassiste technique (slap, tapping, basse 5 cordes) cherche un groupe metal progressif ou post-metal à Marseille. Influences Tool, Meshuggah. Motivé, sérieux.',
 'Musicien cherche groupe','Basse','Metal','Marseille',NULL,NULL,'published',CURRENT_DATE - 5),

-- Noémie — violoniste Strasbourg
('ec502bed-56af-432e-8bc2-5373bd5ba481',
 'Groupe folk celtique cherche musiciens Strasbourg',
 'Notre groupe de musique traditionnelle celtique cherche un guitariste acoustique et un accordéoniste pour compléter la formation. Répètes le vendredi soir à Strasbourg.',
 'Groupe cherche musicien','Guitare acoustique','Folk','Strasbourg',NULL,NULL,'published',CURRENT_DATE - 4),

-- Pierre — guitariste blues Bordeaux
('ba4a800b-9d03-423d-bb74-31d14e9109f3',
 'Duo blues cherche pianiste ou organiste — Bordeaux',
 'Guitariste/harmoniciste blues et un chanteur cherchent un pianiste ou organiste pour compléter un trio. Répertoire Chicago blues et Louisiana blues. Concerts réguliers.',
 'Groupe cherche musicien','Piano','Blues','Bordeaux',NULL,NULL,'published',CURRENT_DATE - 6),

('ba4a800b-9d03-423d-bb74-31d14e9109f3',
 'Session blues enregistrement studio — Bordeaux',
 'Je cherche des musiciens pour enregistrer un album de blues acoustique 10 titres. Budget limité mais projet soigné. Basse, batterie, chant cherchés en priorité.',
 'Collaboration studio','Guitare','Blues','Bordeaux',NULL,NULL,'published',CURRENT_DATE - 1),

-- Axelle — chanteuse jazz Paris
('f0bf9717-766b-4d1c-b356-d178836275c3',
 'Chanteuse jazz disponible événements privés Paris',
 'Chanteuse jazz bossa nova disponible pour événements haut de gamme, mariages, soirées d''entreprise. Répertoire bilingue FR/EN, accompagnement trio ou en solo. Devis personnalisé.',
 'Concert / Événement','Chant','Jazz','Paris',400,'concert','published',CURRENT_DATE - 3),

('f0bf9717-766b-4d1c-b356-d178836275c3',
 'Cherche pianiste accompagnateur jazz — Paris',
 'Chanteuse jazz cherche un pianiste pour constituer un duo régulier. Concerts, soirées et studio. Répertoire standards + compositions originales. Partage des cachets.',
 'Musicien cherche groupe','Piano','Jazz','Paris',NULL,NULL,'published',CURRENT_DATE - 1),

-- Kevin — batteur Lille
('a4ae62f1-7143-449d-991a-c9bb4c762aae',
 'Batteur rock/metal cherche groupe Lille',
 'Batteur solide, double pédale maîtrisée. Cherche groupe rock ou metal sérieux sur Lille ou alentours. Disponible soir et week-end. Kit Pearl complet, transport assuré.',
 'Musicien cherche groupe','Batterie','Rock','Lille',NULL,NULL,'published',CURRENT_DATE - 7),

-- Morgane — pianiste indie Rennes
('b33e48a5-8725-425f-a1da-321fe1bc2988',
 'Pianiste électro/indie cherche collab Rennes',
 'Je crée de la musique électro-acoustique avec synth vintage et piano. Cherche un guitariste ou un chanteur pour donner une dimension live à mes compositions. Projet d''EP prévu.',
 'Collaboration studio','Piano','Indie','Rennes',NULL,NULL,'published',CURRENT_DATE - 5),

-- Florian — guitariste Nice
('070274f4-141b-4bf5-98a0-0d2947a899bb',
 'Cours de guitare metal et technique — Nice',
 'Guitariste métal professionnel propose cours de guitare électrique. Technique avancée : sweep picking, legato, économie de mouvement. Débutants acceptés, méthode progressive.',
 'Cours de musique','Guitare électrique','Metal','Nice',40,'heure','published',CURRENT_DATE - 4),

('070274f4-141b-4bf5-98a0-0d2947a899bb',
 'Groupe metal cherche bassiste technique — Nice',
 'Groupe metal bien établi à Nice cherche un bassiste technique et motivé. Nous avons déjà des dates de concert. Influences Gojira, Trivium. Niveau confirmé requis.',
 'Groupe cherche musicien','Basse','Metal','Nice',NULL,NULL,'published',CURRENT_DATE - 1),

-- Pauline — bassiste funk Paris
('2147b0d0-256d-4e31-affa-e0faed9837e9',
 'Bassiste funk cherche formation groove Paris',
 'Bassiste funk groove cherche groupe soul, funk ou jazz-funk sur Paris. Influences Victor Wooten, Bootsy Collins. Technique solide, sens du collectif. Toujours partante.',
 'Musicien cherche groupe','Basse','Funk','Paris',NULL,NULL,'published',CURRENT_DATE - 3),

-- Adrien — saxophoniste Lyon
('038ecc3d-e464-49bc-9217-32f179e15a50',
 'Saxophoniste disponible concerts et mariages — Lyon',
 'Saxophoniste et clarinettiste, 12 ans d''expérience. Disponible pour mariages, cocktails et festivals. Styles : jazz, soul, funk, pop. Solo ou avec accompagnement. Devis gratuit.',
 'Concert / Événement','Saxophone','Jazz','Lyon',250,'concert','published',CURRENT_DATE - 2),

('038ecc3d-e464-49bc-9217-32f179e15a50',
 'Cherche batteur et pianiste pour quartet jazz Lyon',
 'Je cherche à former un quartet jazz à Lyon : sax + contrebasse (trouvée) + batterie + piano. Répertoire standards et compositions modernes. Concerts réguliers visés.',
 'Groupe cherche musicien','Tous instruments','Jazz','Lyon',NULL,NULL,'published',CURRENT_DATE);
```
