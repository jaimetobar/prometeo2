# == Schema Information
#
# Table name: accreditations_courses
#
#  id               :integer          not null, primary key
#  course_id        :integer
#  accreditation_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class AccreditationsCourse < ActiveRecord::Base
  belongs_to :accreditation
  belongs_to :course

  validates :accreditation, presence: true, if: -> { self.course.nil? }
  validates :course, presence: true, if: -> { self.accreditation.nil? }

end
