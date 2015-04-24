class CreateAccreditationsCourses < ActiveRecord::Migration
  def change
    create_table :accreditations_courses do |t|
      t.references :course, index: true
      t.references :accreditation, index: true
      t.timestamps
    end
  end
end
