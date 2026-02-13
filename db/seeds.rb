puts "🐝 Nettoyage de la base de données..."
Contribution.destroy_all
StaticContent.destroy_all
Portrait.destroy_all

puts "🐝 Création des contenus statiques (droits)..."

StaticContent.create!([
  { category: 'droits', slug: 'protection-internationale', title: 'Demande de protection internationale', description: "Comment déposer une demande auprès de l'OFPRA, les délais à prévoir, et ce que signifie l'obtention du statut de réfugié.", icon: '📄', tags: ['protection', 'demande', 'all'], position: 1 },
  { category: 'droits', slug: 'protection-ukrainienne', title: 'Protection temporaire ukrainienne', description: 'Le régime accordé aux ressortissants ukrainiens depuis 2022 : droits spécifiques, titre de séjour, accès au travail.', icon: '🛡', tags: ['protection', 'all'], position: 2 },
  { category: 'droits', slug: 'autorisation-travail', title: 'Autorisation de travail', description: 'Conditions pour exercer une activité professionnelle, validation des diplômes étrangers, droits des travailleurs réfugiés.', icon: '💼', tags: ['travail', 'all'], position: 3 },
  { category: 'droits', slug: 'regroupement-familial', title: 'Regroupement familial', description: 'Procédure pour faire venir votre famille en France, conditions requises, délais de traitement selon votre statut.', icon: '👨‍👩‍👧', tags: ['famille', 'all'], position: 4 },
  { category: 'droits', slug: 'hebergement-cada', title: 'Hébergement & CADA', description: "Centres d'Accueil pour Demandeurs d'Asile, droits au logement, associations d'aide à l'hébergement d'urgence.", icon: '🏠', tags: ['demande', 'travail', 'all'], position: 5 },
  { category: 'droits', slug: 'scolarisation-enfants', title: 'Scolarisation des enfants', description: 'Droit à la scolarisation pour tous les enfants dès 3 ans, indépendamment du statut administratif des parents.', icon: '🎓', tags: ['protection', 'travail', 'all'], position: 6 }
])

puts "🐝 Création des portraits..."

Portrait.create!([
  {
    name: 'Olena Kovalenko', origin: 'Ukraine · Arrivée en 2022', flag: '🇺🇦',
    quote: "J'ai transformé ma peur en moteur. Mon école de drones emploie aujourd'hui 4 personnes à Nancy.",
    tags: ['Entrepreneuriat', 'Tech'], avatar_color: '#C45A2A',
    stripe_gradient: 'linear-gradient(90deg,#C45A2A,#E87A4A)',
    photo_url: 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=400&q=80',
    position: 1,
    translations: {
      'en' => { 'quote' => 'I turned my fear into fuel. My drone school now employs 4 people in Nancy.', 'origin' => 'Ukraine · Arrived in 2022', 'tags' => ['Entrepreneurship', 'Tech'] },
      'ar' => { 'quote' => 'حوّلت خوفي إلى محرك. مدرسة الطائرات المسيّرة توظف اليوم 4 أشخاص في نانسي.', 'origin' => 'أوكرانيا · وصلت في 2022', 'tags' => ['ريادة الأعمال', 'تكنولوجيا'] },
      'uk' => { 'quote' => 'Я перетворила свій страх на двигун. Моя школа дронів сьогодні працевлаштовує 4 людей у Нансі.', 'origin' => 'Україна · Прибула в 2022', 'tags' => ['Підприємництво', 'Технології'] },
      'prs' => { 'quote' => 'ترس خود را به انگیزه تبدیل کردم. مکتب درون‌های من اکنون ۴ نفر را در نانسی استخدام کرده.', 'origin' => 'اوکراین · رسیده در ۲۰۲۲', 'tags' => ['کارآفرینی', 'تکنالوژی'] },
      'es' => { 'quote' => 'Transformé mi miedo en motor. Mi escuela de drones emplea hoy a 4 personas en Nancy.', 'origin' => 'Ucrania · Llegada en 2022', 'tags' => ['Emprendimiento', 'Tecnología'] }
    }
  },
  {
    name: 'Amine Rachid', origin: 'Syrie · Arrivé en 2015', flag: '🇸🇾',
    quote: "Le français m'a coûté deux ans de travail acharné. Aujourd'hui je le parle mieux que certains Français !",
    tags: ['Intégration', 'Commerce'], avatar_color: '#1A5B9A',
    stripe_gradient: 'linear-gradient(90deg,#1A5B9A,#3A80C0)',
    photo_url: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&q=80',
    position: 2,
    translations: {
      'en' => { 'quote' => 'French cost me two years of hard work. Today I speak it better than some French people!', 'origin' => 'Syria · Arrived in 2015', 'tags' => ['Integration', 'Business'] },
      'ar' => { 'quote' => 'كلّفتني الفرنسية سنتين من العمل الشاق. اليوم أتحدثها أفضل من بعض الفرنسيين!', 'origin' => 'سوريا · وصل في 2015', 'tags' => ['اندماج', 'تجارة'] },
      'uk' => { 'quote' => 'Французька коштувала мені два роки наполегливої праці. Сьогодні я розмовляю нею краще за деяких французів!', 'origin' => 'Сирія · Прибув у 2015', 'tags' => ['Інтеграція', 'Комерція'] },
      'prs' => { 'quote' => 'فرانسوی دو سال تلاش سخت از من گرفت. امروز بهتر از بعضی فرانسوی‌ها صحبت می‌کنم!', 'origin' => 'سوریه · رسیده در ۲۰۱۵', 'tags' => ['ادغام', 'تجارت'] },
      'es' => { 'quote' => 'El francés me costó dos años de trabajo duro. ¡Hoy lo hablo mejor que algunos franceses!', 'origin' => 'Siria · Llegado en 2015', 'tags' => ['Integración', 'Comercio'] }
    }
  },
  {
    name: 'Mariame Diallo', origin: 'Congo · Arrivée en 2019', flag: '🇨🇩',
    quote: "Mon traiteur africain est né d'une envie simple : partager ce que ma mère m'avait appris.",
    tags: ['Culture', 'Cuisine'], avatar_color: '#F5A800',
    stripe_gradient: 'linear-gradient(90deg,#F5A800,#FFD166)',
    photo_url: 'https://images.unsplash.com/photo-1531123897727-8f129e1688ce?w=400&q=80',
    position: 3,
    translations: {
      'en' => { 'quote' => 'My African catering business was born from a simple desire: to share what my mother taught me.', 'origin' => 'Congo · Arrived in 2019', 'tags' => ['Culture', 'Cooking'] },
      'ar' => { 'quote' => 'مطبخي الأفريقي وُلد من رغبة بسيطة: مشاركة ما علّمتني إياه أمي.', 'origin' => 'الكونغو · وصلت في 2019', 'tags' => ['ثقافة', 'مطبخ'] },
      'uk' => { 'quote' => 'Мій африканський кейтеринг народився з простого бажання: поділитися тим, чому мене навчила мама.', 'origin' => 'Конго · Прибула в 2019', 'tags' => ['Культура', 'Кулінарія'] },
      'prs' => { 'quote' => 'کسب‌وکار غذای آفریقایی من از یک آرزوی ساده به دنیا آمد: به اشتراک گذاشتن آنچه مادرم به من یاد داده بود.', 'origin' => 'کنگو · رسیده در ۲۰۱۹', 'tags' => ['فرهنگ', 'آشپزی'] },
      'es' => { 'quote' => 'Mi servicio de catering africano nació de un deseo simple: compartir lo que mi madre me había enseñado.', 'origin' => 'Congo · Llegada en 2019', 'tags' => ['Cultura', 'Cocina'] }
    }
  }
])

puts "🐝 Création des contributions initiales..."

Contribution.create!([
  {
    contribution_type: 'fle', title: 'Cours de FLE gratuit — Croix-Rouge Nancy',
    description: 'La Croix-Rouge propose des cours de français pour tous niveaux chaque mardi et jeudi de 18h à 20h.',
    location: 'Nancy, 54000', contact_info: 'croixrouge-nancy@example.fr',
    author_name: 'Samir B.', author_flag: '🇲🇦',
    image_url: 'https://images.unsplash.com/photo-1546410531-bb4caa6b424d?w=400&q=80',
    translations: {
      'en' => { 'title' => 'Free French course — Red Cross Nancy', 'description' => 'The Red Cross offers French courses for all levels every Tuesday and Thursday from 6pm to 8pm.' },
      'ar' => { 'title' => 'دروس فرنسية مجانية — الصليب الأحمر نانسي', 'description' => 'يقدم الصليب الأحمر دروس فرنسية لجميع المستويات كل ثلاثاء وخميس من 18 إلى 20.' },
      'uk' => { 'title' => 'Безкоштовні курси французької — Червоний Хрест Нансі', 'description' => 'Червоний Хрест пропонує курси французької для всіх рівнів щовівторка та щочетверга з 18:00 до 20:00.' },
      'prs' => { 'title' => 'دوره رایگان فرانسوی — صلیب سرخ نانسی', 'description' => 'صلیب سرخ هر سه‌شنبه و پنج‌شنبه از ساعت ۱۸ تا ۲۰ دوره‌های فرانسوی برای همه سطوح ارائه می‌دهد.' },
      'es' => { 'title' => 'Curso de francés gratuito — Cruz Roja Nancy', 'description' => 'La Cruz Roja ofrece cursos de francés para todos los niveles cada martes y jueves de 18h a 20h.' }
    }
  },
  {
    contribution_type: 'event', title: 'Soirée cuisine géorgienne partagée',
    description: 'Venez partager un repas géorgien préparé par Nino et sa famille.',
    location: 'Nancy, 54000', author_name: 'Nino T.', author_flag: '🇬🇪',
    image_url: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=400&q=80',
    translations: {
      'en' => { 'title' => 'Georgian cooking evening', 'description' => 'Come share a Georgian meal prepared by Nino and his family.' },
      'ar' => { 'title' => 'أمسية طبخ جورجي مشتركة', 'description' => 'تعالوا لمشاركة وجبة جورجية حضّرها نينو وعائلته.' },
      'uk' => { 'title' => 'Вечір грузинської кухні', 'description' => 'Приходьте розділити грузинську трапезу, приготовлену Ніно та його родиною.' },
      'prs' => { 'title' => 'شب آشپزی گرجستانی', 'description' => 'بیایید غذای گرجستانی را که نینو و خانواده‌اش آماده کرده‌اند بخورید.' },
      'es' => { 'title' => 'Velada de cocina georgiana compartida', 'description' => 'Ven a compartir una comida georgiana preparada por Nino y su familia.' }
    }
  },
  {
    contribution_type: 'enterprise', title: 'Drone Academy Ukraine',
    description: 'École de pilotage de drones. Formation civile et prestations aériennes.',
    location: 'Nancy, 54000', contact_info: 'drone-academy.fr',
    author_name: 'Olena K.', author_flag: '🇺🇦',
    image_url: 'https://images.unsplash.com/photo-1473968512647-3e447244af8f?w=400&q=80',
    translations: {
      'en' => { 'title' => 'Drone Academy Ukraine', 'description' => 'Drone flying school. Civilian training and aerial services.' },
      'ar' => { 'title' => 'أكاديمية الطائرات المسيّرة أوكرانيا', 'description' => 'مدرسة طيران الطائرات المسيّرة. تدريب مدني وخدمات جوية.' },
      'uk' => { 'title' => 'Drone Academy Ukraine', 'description' => 'Школа пілотування дронів. Цивільне навчання та аерозйомка.' },
      'prs' => { 'title' => 'آکادمی درون اوکراین', 'description' => 'مکتب پرواز درون‌ها. آموزش غیرنظامی و خدمات هوایی.' },
      'es' => { 'title' => 'Drone Academy Ukraine', 'description' => 'Escuela de pilotaje de drones. Formación civil y servicios aéreos.' }
    }
  },
  {
    contribution_type: 'portrait', title: 'De Kaboul à ingénieur chez Stellantis',
    description: "Parcours d'un ingénieur afghan, de la validation de diplômes au CDI.",
    location: 'Nancy, 54000', author_name: 'Kaveh A.', author_flag: '🇦🇫',
    image_url: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&q=80',
    translations: {
      'en' => { 'title' => 'From Kabul to engineer at Stellantis', 'description' => 'Journey of an Afghan engineer, from diploma validation to permanent contract.' },
      'ar' => { 'title' => 'من كابول إلى مهندس في ستيلانتيس', 'description' => 'مسار مهندس أفغاني، من معادلة الشهادات إلى العقد الدائم.' },
      'uk' => { 'title' => 'Від Кабула до інженера в Stellantis', 'description' => 'Шлях афганського інженера від визнання дипломів до безстрокового контракту.' },
      'prs' => { 'title' => 'از کابل تا مهندس در استلانتیس', 'description' => 'مسیر یک مهندس افغان، از تأیید دیپلوم تا قرارداد دایمی.' },
      'es' => { 'title' => 'De Kabul a ingeniero en Stellantis', 'description' => 'Recorrido de un ingeniero afgano, de la validación de diplomas al contrato indefinido.' }
    }
  },
  {
    contribution_type: 'fle', title: 'Tandem linguistique',
    description: 'Échange avec des étudiants français. Gratuit.',
    location: 'Nancy, 54000', contact_info: 'tandem.univ-lorraine.fr',
    author_name: 'Marie L.', author_flag: '🇫🇷',
    image_url: 'https://images.unsplash.com/photo-1523240795612-9a054b0db644?w=400&q=80',
    translations: {
      'en' => { 'title' => 'Language exchange', 'description' => 'Exchange with French students. Free.' },
      'ar' => { 'title' => 'تبادل لغوي', 'description' => 'تبادل مع طلاب فرنسيين. مجاني.' },
      'uk' => { 'title' => 'Мовний тандем', 'description' => 'Обмін з французькими студентами. Безкоштовно.' },
      'prs' => { 'title' => 'تبادل زبانی', 'description' => 'تبادل با محصلان فرانسوی. رایگان.' },
      'es' => { 'title' => 'Intercambio lingüístico', 'description' => 'Intercambio con estudiantes franceses. Gratuito.' }
    }
  },
  {
    contribution_type: 'event', title: 'Concert de musique ukrainienne',
    description: 'Entrée libre sur réservation.',
    location: 'Nancy, 54000', contact_info: 'slava-nancy.fr',
    author_name: 'Yulia S.', author_flag: '🇺🇦',
    image_url: 'https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?w=400&q=80',
    translations: {
      'en' => { 'title' => 'Ukrainian music concert', 'description' => 'Free entry with reservation.' },
      'ar' => { 'title' => 'حفل موسيقى أوكرانية', 'description' => 'دخول مجاني بالحجز.' },
      'uk' => { 'title' => 'Концерт української музики', 'description' => 'Вхід вільний за попереднім записом.' },
      'prs' => { 'title' => 'کنسرت موسیقی اوکراینی', 'description' => 'ورود رایگان با رزرو.' },
      'es' => { 'title' => 'Concierto de música ucraniana', 'description' => 'Entrada libre con reserva.' }
    }
  }
])

puts "🐝 Terminé ! #{Contribution.count} contributions, #{StaticContent.count} contenus, #{Portrait.count} portraits."
