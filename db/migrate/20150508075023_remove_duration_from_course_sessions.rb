class RemoveDurationFromCourseSessions < ActiveRecord::Migration
  def change
    remove_column :course_sessions, :duration, :string
  end
end
