# == Schema Information
#
# Table name: accreditation_suggestions
#
#  id               :integer          not null, primary key
#  accreditation_id :integer
#  suggestion_id    :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class AccreditationSuggestion < ActiveRecord::Base
  belongs_to :accreditation
  belongs_to :suggestion, class_name: 'Accreditation'

  validates :suggestion, presence: true
end
