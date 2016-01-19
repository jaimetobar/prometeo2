class SetDefaultValuesToAccreditations < ActiveRecord::Migration
  def change
    Accreditation.update_all(is_certification: false,advanced: false)
  end
end
