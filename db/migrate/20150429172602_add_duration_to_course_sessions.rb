class AddDurationToCourseSessions < ActiveRecord::Migration
  def change
    add_column :course_sessions, :duration, :string
    change_column :course_sessions, :start_date, :date
    change_column :course_sessions, :end_date, :date
  end
end
