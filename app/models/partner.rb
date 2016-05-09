# == Schema Information
#
# Table name: partners
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  account_id :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Partner < ActiveRecord::Base

  has_many :users
  has_many :contacts

  validates :name, presence: true
  validates :account_id, presence: true

  accepts_nested_attributes_for :contacts, allow_destroy: true
end
