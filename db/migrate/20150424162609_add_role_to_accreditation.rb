class AddRoleToAccreditation < ActiveRecord::Migration
  def change
    add_column :accreditations, :role, :integer
  end
end
