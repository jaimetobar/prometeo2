# == Schema Information
#
# Table name: subscriptions
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  course_id        :integer
#  notifications_on :boolean
#  finished         :boolean
#  created_at       :datetime
#  updated_at       :datetime
#  accreditation_id :integer
#

require 'rails_helper'

RSpec.describe Subscription, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
