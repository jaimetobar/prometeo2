# == Schema Information
#
# Table name: courses
#
#  id                 :integer          not null, primary key
#  category           :integer
#  created_at         :datetime
#  updated_at         :datetime
#  for_sales_engineer :boolean
#  for_sales          :boolean
#  for_delivery       :boolean
#  session_type       :integer
#  duration           :integer
#

require 'rails_helper'

RSpec.describe Course, type: :model do
  context "associations" do

    xit "should delete dependent children" do
      # destroy subscriptions
      # destroy course_session
    end
  end
end
