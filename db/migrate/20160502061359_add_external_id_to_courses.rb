class AddExternalIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :external_id, :string
  end
end
