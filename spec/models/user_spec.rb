# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  email       :string(255)
#  country     :string(255)
#  partner     :string(255)
#  role        :integer
#  created_at  :datetime
#  updated_at  :datetime
#  email_token :string(255)
#  name        :string(255)
#  partner_id  :integer
#

require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
