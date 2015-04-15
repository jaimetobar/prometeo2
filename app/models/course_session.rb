# == Schema Information
#
# Table name: course_sessions
#
#  id         :integer          not null, primary key
#  course_id  :integer
#  start_date :datetime
#  end_date   :datetime
#  created_at :datetime
#  updated_at :datetime
#

class CourseSession < ActiveRecord::Base
  belongs_to :course

  def duration_in_days
    TimeDifference.between(
      self.start_date,self.end_date
    ).in_days.round(1)
  end
end
