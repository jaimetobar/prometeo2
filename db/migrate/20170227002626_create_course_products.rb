class CreateCourseProducts < ActiveRecord::Migration
  def change
    create_table :course_products do |t|
      t.references :product, index: true
      t.references :course, index: true
    end
  end
end
