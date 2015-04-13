# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  country    :string(255)
#  partner    :string(255)
#  role       :integer
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :user do
    email "MyString"
country "MyString"
partner "MyString"
role 1
  end

end
