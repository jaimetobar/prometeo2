#!/usr/bin/env ruby

ENV['RAILS_ENV'] ||= 'production'

require File.expand_path("./config/environment", ENV['OPENSHIFT_REPO_DIR'])

start_date = Date.parse("#{Time.now}")+8.days
User.notify_upcoming_courses(start_date)
