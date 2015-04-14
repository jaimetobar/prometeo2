# == Schema Information
#
# Table name: subscriptions
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  course_id        :integer
#  notifications_on :boolean
#  finished         :boolean
#  created_at       :datetime
#  updated_at       :datetime
#

FactoryGirl.define do
  factory :subscription do
    user nil
    course nil
    notifications_on false
    finished false
  end

end
