# rake db:seed:seed_file_name # Name of the file EXCLUDING the .rb extension
case Rails.env
when "development"
  CourseSession.destroy_all
  Course.all.each do |course|
    13.times do |i|
      CourseSession.create(
       course_id: course.id,
       start_date: DateTime.now + rand(5).days,
       end_date: DateTime.now + 2.months + i.days + rand(3).days + 1.hour
       )
    end
  end
end
