# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  partner_id :integer
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
  belongs_to :partner

  validates :email, presence: true, email: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
