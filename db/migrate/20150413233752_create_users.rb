class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :country
      t.string :partner
      t.integer :role

      t.timestamps
    end
  end
end
