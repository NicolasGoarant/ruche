puts "🐝 Nettoyage de la base de données..."
Contribution.destroy_all
StaticContent.destroy_all
Portrait.destroy_all

puts "🐝 Création des contenus statiques (droits)..."

StaticContent.create!([
  {
    category: 'droits',
    slug: 'protection-internationale',
    title: 'Demande de protection internationale',
    description: 'Comment déposer une demande auprès de l\'OFPRA, les délais à prévoir, et ce que signifie l\'obtention du statut de réfugié.',
    icon: '📄',
    tags: ['protection', 'demande', 'all'],
    position: 1
  },
  {
    category: 'droits',
    slug: 'protection-ukrainienne',
    title: 'Protection temporaire ukrainienne',
    description: 'Le régime accordé aux ressortissants ukrainiens depuis 2022 : droits spécifiques, titre de séjour, accès au travail.',
    icon: '🛡',
    tags: ['protection', 'all'],
    position: 2
  },
  {
    category: 'droits',
    slug: 'autorisation-travail',
    title: 'Autorisation de travail',
    description: 'Conditions pour exercer une activité professionnelle, validation des diplômes étrangers, droits des travailleurs réfugiés.',
    icon: '💼',
    tags: ['travail', 'all'],
    position: 3
  },
  {
    category: 'droits',
    slug: 'regroupement-familial',
    title: 'Regroupement familial',
    description: 'Procédure pour faire venir votre famille en France, conditions requises, délais de traitement selon votre statut.',
    icon: '👨‍👩‍👧',
    tags: ['famille', 'all'],
    position: 4
  },
  {
    category: 'droits',
    slug: 'hebergement-cada',
    title: 'Hébergement & CADA',
    description: 'Centres d\'Accueil pour Demandeurs d\'Asile, droits au logement, associations d\'aide à l\'hébergement d\'urgence.',
    icon: '🏠',
    tags: ['demande', 'travail', 'all'],
    position: 5
  },
  {
    category: 'droits',
    slug: 'scolarisation-enfants',
    title: 'Scolarisation des enfants',
    description: 'Droit à la scolarisation pour tous les enfants dès 3 ans, indépendamment du statut administratif des parents.',
    icon: '🎓',
    tags: ['protection', 'travail', 'all'],
    position: 6
  }
])

puts "🐝 Création des portraits..."

Portrait.create!([
  {
    name: 'Olena Kovalenko',
    origin: 'Ukraine · Arrivée en 2022',
    flag: '🇺🇦',
    quote: 'J\'ai transformé ma peur en moteur. Mon école de drones emploie aujourd\'hui 4 personnes à Nancy.',
    tags: ['Entrepreneuriat', 'Tech'],
    avatar_color: '#C45A2A',
    stripe_gradient: 'linear-gradient(90deg,#C45A2A,#E87A4A)',
    position: 1
  },
  {
    name: 'Amine Rachid',
    origin: 'Syrie · Arrivé en 2015',
    flag: '🇸🇾',
    quote: 'Le français m\'a coûté deux ans de travail acharné. Aujourd\'hui je le parle mieux que certains Français !',
    tags: ['Intégration', 'Commerce'],
    avatar_color: '#1A5B9A',
    stripe_gradient: 'linear-gradient(90deg,#1A5B9A,#3A80C0)',
    position: 2
  },
  {
    name: 'Mariame Diallo',
    origin: 'Congo · Arrivée en 2019',
    flag: '🇨🇩',
    quote: 'Mon traiteur africain est né d\'une envie simple : partager ce que ma mère m\'avait appris.',
    tags: ['Culture', 'Cuisine'],
    avatar_color: '#F5A800',
    stripe_gradient: 'linear-gradient(90deg,#F5A800,#FFD166)',
    position: 3
  },
  {
    name: 'Kaveh Ahmadi',
    origin: 'Afghanistan · Arrivé en 2021',
    flag: '🇦🇫',
    quote: 'J\'étais ingénieur à Kaboul. Ici, j\'ai dû tout recommencer. Mais recommencer m\'a rendu plus fort.',
    tags: ['Ingénierie', 'Résilience'],
    avatar_color: '#6A3A9A',
    stripe_gradient: 'linear-gradient(90deg,#6A3A9A,#9A60C0)',
    position: 4
  }
])

puts "🐝 Création des contributions initiales..."

Contribution.create!([
  {
    contribution_type: 'fle',
    title: 'Cours de FLE gratuit — Croix-Rouge Nancy',
    description: 'La Croix-Rouge propose des cours de français pour tous niveaux chaque mardi et jeudi de 18h à 20h.',
    location: 'Nancy, 54000',
    contact_info: 'croixrouge-nancy@example.fr',
    author_name: 'Samir B.',
    author_flag: '🇲🇦',
    image_url: 'https://images.unsplash.com/photo-1546410531-bb4caa6b424d?w=400&q=80'
  },
  {
    contribution_type: 'event',
    title: 'Soirée cuisine géorgienne partagée',
    description: 'Venez partager un repas géorgien préparé par Nino et sa famille.',
    location: 'Nancy, 54000',
    author_name: 'Nino T.',
    author_flag: '🇬🇪',
    image_url: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400&q=80'
  },
  {
    contribution_type: 'enterprise',
    title: 'Drone Academy Ukraine',
    description: 'École de pilotage de drones. Formation civile et prestations aériennes.',
    location: 'Nancy, 54000',
    contact_info: 'drone-academy.fr',
    author_name: 'Olena K.',
    author_flag: '🇺🇦',
    image_url: 'https://images.unsplash.com/photo-1473968512647-3e447244af8f?w=400&q=80'
  },
  {
    contribution_type: 'portrait',
    title: 'De Kaboul à ingénieur chez Stellantis',
    description: 'Parcours d\'un ingénieur afghan, de la validation de diplômes au CDI.',
    location: 'Nancy, 54000',
    author_name: 'Kaveh A.',
    author_flag: '🇦🇫',
    image_url: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&q=80'
  },
  {
    contribution_type: 'fle',
    title: 'Tandem linguistique',
    description: 'Échange avec des étudiants français. Gratuit.',
    location: 'Nancy, 54000',
    contact_info: 'tandem.univ-lorraine.fr',
    author_name: 'Marie L.',
    author_flag: '🇫🇷',
    image_url: 'https://images.unsplash.com/photo-1523240795612-9a054b0db644?w=400&q=80'
  },
  {
    contribution_type: 'event',
    title: 'Concert de musique ukrainienne',
    description: 'Entrée libre sur réservation.',
    location: 'Nancy, 54000',
    contact_info: 'slava-nancy.fr',
    author_name: 'Yulia S.',
    author_flag: '🇺🇦',
    image_url: 'https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?w=400&q=80'
  }
])

puts "🐝 Terminé ! #{Contribution.count} contributions, #{StaticContent.count} contenus, #{Portrait.count} portraits."
