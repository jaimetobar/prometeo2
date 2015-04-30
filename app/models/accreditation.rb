# == Schema Information
#
# Table name: accreditations
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  role        :integer
#  description :text
#

class Accreditation < ActiveRecord::Base

  has_many :accreditations_courses, dependent: :delete_all
  has_many :courses, through: :accreditations_courses

  accepts_nested_attributes_for :accreditations_courses, allow_destroy: true

  enum role: User.roles.keys

  validates :name, presence: true
  validates :role, presence: true
end
