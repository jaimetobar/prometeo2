# == Schema Information
#
# Table name: accreditations
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  role        :integer
#  description :text
#

FactoryGirl.define do
  factory :accreditation do
    name "Acreditation1"
    role "delivery"
    description "This is the description 1 from the the Acreditation1"
  end

end
