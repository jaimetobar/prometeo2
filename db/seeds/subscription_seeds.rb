# rake db:seed:seed_file_name # Name of the file EXCLUDING the .rb extension
case Rails.env
  when "development"
    User.all.map do |user|
      rand(1..4).times do
        Subscription.create(
          user_id: user.id,
          course_id: Course.order("RANDOM()").first.id,
          notifications_on: [true, false].sample,
          finished: [true, false].sample
        )
    end
  end
end
