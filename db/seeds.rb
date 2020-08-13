require 'faker'


User.destroy_all
User.reset_pk_sequence
Event.destroy_all
Event.reset_pk_sequence
Attendance.destroy_all
Attendance.reset_pk_sequence

Faker::Config.locale = 'fr'


events = Array.new
users = Array.new


5.times do 
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name  
  user = User.create(
  first_name: first_name,
  last_name: last_name,
  email: (first_name.downcase.unicode_normalize(:nfkd).encode('ASCII', replace: '') + last_name.downcase.unicode_normalize(:nfkd).encode('ASCII', replace: '') + "@yopmail.com").to_s,
  password: "Azerty"
  )
  if user.id != nil
    users << user
    puts "Seeding User #{user.id} #{user.first_name} #{user.last_name} #{user.email}"
  end
end

puts "------------"

i = 0
6.times do 
    
    event = Event.create(
    start_date: Faker::Date.between(from: '2020-09-23', to: '2020-12-25'),
    title: ["Alimenter votre projet sportif à long terme","Développer les partenariats ONG-Entreprises à l'international","Séminaire De Formation Aide Au Développement","Programme toi à la réussite","Soirée Découverte Hypnose Spirituelle", "Pour la rentrée, je veux un job avec plus de sens !"].fetch(i),
    duration: [5, 10, 15, 20].sample,
    description: ["Nous commencerons à faire connaissances puis à entamer un exercice de respiration afin de nous préparer à échanger les unes et les autres sur nos projets, nos besoins dans notre pratique sportive, c'est un soutien constructif que chacune apportera au groupe et à soi même.","Une journée rythmée par des temps de rencontres entre ONG et Entreprises et la réponse à toutes les questions que vous vous posez sur les partenariats ONG-Entreprises.","Votre envie de faire évoluer vos canaux de communication et de recherche de prospects en interne vous tracasse car vous n’avez malheureusement pas le temps, les connaissances ou les compétences nécessaires ?","Une journée pour fixer les objectifs de l'année en accord avec son système de valeur et comprendre comment construire une identité gagnante", "Hypnose Spirituelle Symbolique est une nouvelle forme d’Hypnose basée sur l’utilisation de techniques spécifiques. Elle intègre la dimension spirituelle de l’être dans les processus thérapeutiques et au delà de la distinction habituelle entre l’esprit conscient et l’inconscient, elle introduit la notion de surconscient", "Nous te proposons de te présenter le parcours d'accompagnement Hisse & Haut, une alternative au bilan de compétences, pour te reconnecter à tes envies, tes valeurs, les causes qui te tiennent à coeur, et construire ta prochaine étape professionnelle. Un parcours où tu sera entouré.e et soutenu.e par un collectif bienveillant pour atteindre tes objectifs !"].fetch(i),
    price: [5, 10, 15, 20, 30, 50].sample,
    user_id: users[rand(0..((users.size) -1))].id,
    location: Faker::Address.city
    )
    if event.id != nil
        events << event
        puts "Seeding Event #{event.id} #{event.title}"
    end
    i = i+1
end

puts "------------"

100.times do
    attendance = Attendance.create(
      user_id: users[rand(0..4)].id,
      event_id: events[rand(0..((events.size) -1))].id,
      stripe_customer_id: Faker::Lorem.sentence(word_count: 2, supplemental: false, random_words_to_add: 2)
      )
    if attendance.id != nil
      puts "Seeding Attendance #{attendance.id}"
    end
end
