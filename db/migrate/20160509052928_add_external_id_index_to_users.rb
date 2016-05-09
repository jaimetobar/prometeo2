class AddExternalIdIndexToUsers < ActiveRecord::Migration
  def change
    add_index :courses, :external_id
  end
end
