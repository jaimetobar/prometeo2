class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :role
      t.integer :category
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
