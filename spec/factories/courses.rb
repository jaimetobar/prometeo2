# == Schema Information
#
# Table name: courses
#
#  id                 :integer          not null, primary key
#  category           :integer
#  created_at         :datetime
#  updated_at         :datetime
#  for_sales_engineer :boolean
#  for_sales          :boolean
#  for_delivery       :boolean
#  session_type       :integer
#  duration           :integer
#

FactoryGirl.define do
  factory :course do
    name "Course #{Faker::Hacker.abbreviation}"
    # role "delivery"
    category "middleware"
    description "The course test text"
    for_sales_engineer true
    for_sales false
    for_delivery false
    session_type "always_available"
    duration "One test/time"
    # start_date "2015-04-13 18:39:55"
    # end_date "2015-04-20 18:39:55"
  end
end
