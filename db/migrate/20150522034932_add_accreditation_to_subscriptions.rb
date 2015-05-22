class AddAccreditationToSubscriptions < ActiveRecord::Migration
  def change
    add_reference :subscriptions, :accreditation, index: true
  end
end
