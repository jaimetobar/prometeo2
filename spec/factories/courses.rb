# == Schema Information
#
# Table name: courses
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  category           :integer
#  created_at         :datetime
#  updated_at         :datetime
#  description        :text
#  for_sales_engineer :boolean
#  for_sales          :boolean
#  for_delivery       :boolean
#  session_type       :integer
#

FactoryGirl.define do
  factory :course do
    name "MyString"
role 1
category 1
start_date "2015-04-13 18:39:55"
end_date "2015-04-13 18:39:55"
  end

end
