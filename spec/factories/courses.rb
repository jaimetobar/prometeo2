# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  role       :integer
#  category   :integer
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime
#  updated_at :datetime
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
