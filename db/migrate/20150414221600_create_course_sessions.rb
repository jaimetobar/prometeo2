class CreateCourseSessions < ActiveRecord::Migration
  def change
    create_table :course_sessions do |t|
      t.references :course, index: true
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
