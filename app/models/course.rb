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
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :category, presence: true
  validates :accreditation_id, presence: true
  validates :session_type, presence: true
 #acreditation is missing
  validate :any_presence

  belongs_to :accreditation
  has_many :sessions, class_name: "CourseSession"
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :courses_accreditations
  has_many :accreditations, through: :courses_accreditations

  def roles
    rs = []
    rs << :sales_engineer if self.for_sales_engineer
    rs << :sales if self.for_sales
    rs << :delivery if self.for_delivery
    rs
  end

  def which_roles
    rs = if self.for_sales_engineer then "Sales Engineer\n" else "" end
    rs += if self.for_sales then "Sales\n" else "" end
    rs += if self.for_delivery then "Delivery" else "" end
    return rs
  end

  private
  def any_presence
    if [:for_sales_engineer, :for_sales, :for_delivery].all?{ |attr|
        self[attr].blank? }
      errors.add(:any_presence,"You must fill in at least one field")
    end
  end

end
