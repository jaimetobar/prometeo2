desc "Check if there are courses initiaing soon"
task :courses_checker => :environment do
  courses_sessions = CourseSession.where("start_date <= ?", Date.parse("#{Time.now}")+2)
  unless courses_sessions == nil
    courses_sessions.each do |courses_session|
      start_date = courses_session.start_date
      courses_session.course.users.each do |user|
        puts "course session: #{ courses_session } sent to: #{ user.email }, start at: #{start_date}"
        PlanMailer.notifications(user,  courses_session, start_date).deliver
      end
    end
  end
end
desc "Check environment we are in"
task :environment_checker => :environment do
  puts "Hi my first task"
  puts "environment in #{ Rails.env }"
end