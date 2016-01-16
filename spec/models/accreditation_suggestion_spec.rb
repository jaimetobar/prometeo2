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

require 'rails_helper'

RSpec.describe AccreditationSuggestion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
