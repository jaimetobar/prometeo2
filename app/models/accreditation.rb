# == Schema Information
#
# Table name: accreditations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Accreditation < ActiveRecord::Base
  has_many :courses_accreditations
  has_many :courses, through: :courses_accreditations
end
