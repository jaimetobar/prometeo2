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
#

class User < ActiveRecord::Base

  enum role: [:sales_engineer,:sales,:delivery]
  has_many :subscriptions
  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true
  validates :country, presence: true, inclusion: { in: ISO3166::Country.all.map { |name, code| code } }
  validates :partner, presence: true
  validates :role, presence: true
  validates :name, presence: true

  before_create :add_token

  accepts_nested_attributes_for :subscriptions
  scope :search, ->(q) do
    query_string = q.split.join('%')
    where(%Q(
      LOWER(UNACCENT(name)) LIKE LOWER(UNACCENT(:q)) OR
      LOWER(UNACCENT(email)) LIKE LOWER(UNACCENT(:q)) OR
      LOWER(UNACCENT(partner)) LIKE LOWER(UNACCENT(:q))
    ),q: "%#{query_string}%")
  end

  private
  def add_token
    begin
      self.email_token = SecureRandom.hex[0,10].downcase
    end while self.class.exists?(email_token: email_token)
  end
end
