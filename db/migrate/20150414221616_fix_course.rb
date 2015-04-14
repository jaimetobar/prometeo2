class FixCourse < ActiveRecord::Migration
  def change
    remove_column :courses, :role, :integer
    remove_column :courses, :start_date, :datetime
    remove_column :courses, :end_date, :datetime
    add_column :courses, :description, :text
    add_column :courses, :for_sales_engineer, :boolean
    add_column :courses, :for_sales, :boolean
    add_column :courses, :for_delivery, :boolean
    add_column :courses, :session_type, :integer
  end
end
