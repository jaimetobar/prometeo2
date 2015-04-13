class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true
      t.references :course, index: true
      t.boolean :notifications_on
      t.boolean :finished

      t.timestamps
    end
  end
end
