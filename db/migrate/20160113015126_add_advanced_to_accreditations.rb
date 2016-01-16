class AddAdvancedToAccreditations < ActiveRecord::Migration
  def change
    add_column :accreditations, :advanced, :boolean, default: false
  end
end
