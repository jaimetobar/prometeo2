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
#  accreditation_id :integer
#

class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  belongs_to :accreditation

  after_initialize :defaults


  protected
  def defaults
    self.finished ||= false
    self.notifications_on = true if self.notifications_on.nil?
    true
  end

end
