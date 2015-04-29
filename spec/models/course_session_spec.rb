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
#  duration   :string(255)
#

require 'rails_helper'

RSpec.describe CourseSession, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
