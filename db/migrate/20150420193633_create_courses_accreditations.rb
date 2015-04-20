class CreateCoursesAccreditations < ActiveRecord::Migration
  def change
    create_table :courses_accreditations do |t|
      t.integer :course_id
      t.integer :acreditation_id
      t.timestamps
    end
  end
end
