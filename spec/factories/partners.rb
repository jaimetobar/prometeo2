# == Schema Information
#
# Table name: partners
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  account_id :string(255)
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :partner do
    name "MyString"
account_id "MyString"
  end

end
