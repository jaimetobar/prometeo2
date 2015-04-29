# == Schema Information
#
# Table name: accreditations
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  role       :integer
#

require 'rails_helper'

RSpec.describe Accreditation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
