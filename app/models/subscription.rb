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

  def self.attributes_from_courses_and_role(courses,role)
    courses.map do |c|
      accreditation = c.accreditations.where(role: role).take
      accreditation_id = accreditation ? accreditation.id : nil

      { course_id: c.id, accreditation_id: accreditation_id }
    end
  end

  protected
  def defaults
    self.finished ||= false
    self.notifications_on = true if self.notifications_on.nil?
    true
  end

end
