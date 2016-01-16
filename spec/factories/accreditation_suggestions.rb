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

FactoryGirl.define do
  factory :accreditation_suggestion do
    accreditation nil
suggestion_id 1
  end

end
