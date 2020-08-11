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
  users << user
  puts "Seeding User #{user.id} #{user.first_name} #{user.last_name} #{user.email}"
end

puts "------------"


100.times do 
    event = Event.create(
    start_date: Faker::Date.between(from: '2020-07-23', to: '2020-09-25'),
    title: Faker::Lorem.sentence(word_count: 2, supplemental: false, random_words_to_add: 2),
    duration: Faker::Number.between(from: 4, to: 30),
    description: Faker::Lorem.sentence(word_count: 8, supplemental: false, random_words_to_add: 4),
    price: Faker::Number.between(from: 1, to: 1200),
    user_id: users[rand(0..4)].id,
    location: Faker::Address.city
    )
    if event.id != nil
        events << event
        puts "Seeding Event #{event.id} #{event.title}"
    end
end

puts "------------"

1.times do
    attendance = Attendance.create(
      user_id: users[rand(0..4)].id,
      event_id: events[rand(0..((events.size) -1))].id,
      stripe_customer_id: Faker::Lorem.sentence(word_count: 2, supplemental: false, random_words_to_add: 2)
      )
    if attendance.id != nil
      puts "Seeding Attendance #{attendance.id}"
    end
end
