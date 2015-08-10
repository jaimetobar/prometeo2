# rake db:seed:seed_file_name # Name of the file EXCLUDING the .rb extension
case Rails.env
when "development"
  User.all.map do |user|
    rand(1..4).times do
      course = Course.order("RANDOM()").first
      Subscription.create(
        user_id: user.id,
        course_id: course.id,
        notifications_on: [true, false].sample,
        finished: [true, false].sample,
        accreditation: course.accreditations.first
      )
    end
  end
end
