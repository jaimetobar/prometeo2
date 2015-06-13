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
