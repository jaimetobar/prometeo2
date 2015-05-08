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

class CourseSession < ActiveRecord::Base
  belongs_to :course
  validates :start_date, presence: true
  validates :end_date, presence: true

  scope :upcoming, -> { where("start_date > ?", DateTime.now) }

  #source: http://makandracards.com/makandra/984-test-if-two-date-ranges-overlap-in-ruby-or-rails
  def overlaps?(other)
    if other.respond_to? :each
      overlaps = false
      other.each do |o|
        if _overlaps?(o)
          overlaps = true
          break
        end
      end
      return overlaps
    else
      _overlaps?(other)
    end
  end

  private
  def _overlaps?(other)
    (self.start_date - other.end_date) * (other.start_date - self.end_date) >= 0
  end
end
