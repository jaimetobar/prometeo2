# rake db:seed:seed_file_name # Name of the file EXCLUDING the .rb extension
case Rails.env
when "development"
  30.times do
    User.create(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      country: ISO3166::Country.all.map{ |name, code| code }.sample,
      partner: Faker::Name.title,
      role: rand(3)
    )
  end
end
