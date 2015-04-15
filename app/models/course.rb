# == Schema Information
#
# Table name: courses
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  category           :integer
#  created_at         :datetime
#  updated_at         :datetime
#  description        :text
#  for_sales_engineer :boolean
#  for_sales          :boolean
#  for_delivery       :boolean
#  session_type       :integer
#  accreditation_id   :integer
#

class Course < ActiveRecord::Base
  enum category: [:platform,:middleware,:cloud]
  enum session_type: [:always_available,:per_session]

  belongs_to :accreditation
  has_many :sessions, class_name: "CourseSession"
  has_many :subscriptions
  has_many :users, through: :subscriptions

  def roles
    rs = []
    rs << :sales_engineer if self.for_sales_engineer
    rs << :sales if self.for_sales
    rs << :delivery if self.for_delivery
    rs
  end

end
