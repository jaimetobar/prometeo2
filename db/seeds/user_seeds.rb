# rake db:seed:seed_file_name # Name of the file EXCLUDING the .rb extension 
300.times do
  User.create(
    email: Faker::Internet.email,
    country: Faker::Address.country,
    partner: Faker::Name.title,
    role: rand(3)
  )
end