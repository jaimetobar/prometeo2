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

class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
end
