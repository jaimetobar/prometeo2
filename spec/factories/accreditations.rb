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
    name Faker::Name.title
    role "delivery"
    description Faker::Lorem.sentence
  end
end
