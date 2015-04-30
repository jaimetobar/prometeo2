class AddDescriptionToAccreditations < ActiveRecord::Migration
  def change
    add_column :accreditations, :description, :text
  end
end
