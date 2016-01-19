class AddCertificationFieldsToAccreditation < ActiveRecord::Migration
  def change
    add_column :accreditations, :is_certification, :boolean, default: false
  end
end
