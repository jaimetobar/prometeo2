class RenamePartnerToPartnerNameOnUsers < ActiveRecord::Migration
  def change
    rename_column :users, :partner, :partner_name
  end
end
