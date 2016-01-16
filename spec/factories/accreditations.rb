# == Schema Information
#
# Table name: accreditations
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  role       :integer
#  tags       :string(255)
#  category   :integer
#  advanced   :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :accreditation do
    name Faker::Name.title
    role "delivery"
    description Faker::Lorem.sentence

    trait :with_course do
      after(:create) do |accreditation|
        accreditation.courses << create(:course)
      end
    end
  end
end
