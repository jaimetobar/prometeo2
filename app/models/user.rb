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
#

class User < ActiveRecord::Base

  enum role: [:sales_engineer,:sales,:delivery]
  has_many :subscriptions
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :country, presence: true
  validates :partner, presence: true
  validates :role, presence: true
end
