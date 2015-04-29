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
#

class Course < ActiveRecord::Base
  enum category: [:platform,:middleware,:cloud]
  enum session_type: [:always_available,:per_session]

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :category, presence: true
  validates :session_type, presence: true

  validate :validate_presence_of_roles

  has_many :accreditations_courses, dependent: :delete_all
  has_many :accreditations, through: :accreditations_courses
  has_many :course_sessions
  has_many :subscriptions
  has_many :users, through: :subscriptions

  accepts_nested_attributes_for :accreditations_courses, allow_destroy: true
  accepts_nested_attributes_for :course_sessions, allow_destroy: true

  def roles
    rs = []
    rs << :sales_engineer if self.for_sales_engineer
    rs << :sales if self.for_sales
    rs << :delivery if self.for_delivery
    rs
  end

  def which_roles
    self.roles.map(&:to_s).map(&:humanize).join("\n")
  end

  protected
  def validate_presence_of_roles
    errors.add(:roles,"You must fill in at least one role") if self.roles.empty?
  end

end
