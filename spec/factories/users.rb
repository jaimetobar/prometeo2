# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  email       :string(255)
#  country     :string(255)
#  partner     :string(255)
#  role        :integer
#  created_at  :datetime
#  updated_at  :datetime
#  email_token :string(255)
#  name        :string(255)
#

FactoryGirl.define do
  factory :user, aliases: [:subscriber] do
    name Faker::Name.name
    email Faker::Internet.email
    country Faker::Address.country_code #=> "IT"
    partner Faker::Company.name
    role "delivery"
  end
end
