#!/usr/bin/env ruby

ENV['RAILS_ENV'] ||= 'production'

require File.expand_path("./config/environment", ENV['OPENSHIFT_REPO_DIR'])

start_date = Date.parse("#{Time.now}")+2.days
courses_sessions = CourseSession.where("start_date = :start_date", start_date: start_date)
courses = Course.joins(:course_sessions).where("course_sessions.id" => courses_sessions.pluck(:id)).uniq
courses_ids = courses.pluck(:id)
users = User.joins(:subscriptions).where("subscriptions.course_id" => courses.pluck(:id)).uniq

users.each do |u|
  user_subscriptions = u.subscriptions.where(course_id: courses_ids, notifications_on: true)
  unless user_subscriptions.empty?
    PlanMailer.notifications_email(u, user_subscriptions, start_date).deliver
    Rails.logger.info "Notification email sent to: #{ u.email }, start at: #{start_date}"
  end

end
