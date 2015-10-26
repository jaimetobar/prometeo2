# == Schema Information
#
# Table name: accreditations
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  role       :integer
#  tags       :string(255)
#

require 'rails_helper'

RSpec.describe Accreditation, type: :model do

  it "is invalid without name" do
    accreditation = build(:accreditation, name: nil)
    accreditation.valid?
    expect(accreditation.errors[:name]).to include("no puede estar en blanco")
  end
  it "is invalid without role" do
    accreditation = build(:accreditation, role: nil)
    accreditation.valid?
    expect(accreditation.errors[:role]).to include("no puede estar en blanco")
  end

end
