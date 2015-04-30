desc "Check if there are courses initiaing soon"
task :courses_checker => enviroment do
  courses_sessions = CourseSession.where(start_date: Date.parse("#{Time.now}")+2)
  unless courses == nil
    courses_sessions.each do |courses_session|
      courses_session.courses.users.each do |user|
          
      end
    end
  end
end