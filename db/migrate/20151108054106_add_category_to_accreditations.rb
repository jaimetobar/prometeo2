class AddCategoryToAccreditations < ActiveRecord::Migration
  def change
    add_column :accreditations, :category, :integer
  end
end
