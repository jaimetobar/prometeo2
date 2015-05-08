# == Schema Information
#
# Table name: course_sessions
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  start_date :date
#  end_date   :date
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :course_session do
    course nil
start_date "2015-04-14 17:16:00"
end_date "2015-04-14 17:16:00"
  end

end
