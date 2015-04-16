# == Schema Information
#
# Table name: accreditations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :accreditation do
    name "MyString"
  end

end
