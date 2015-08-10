# == Schema Information
#
# Table name: accreditations
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  role        :integer
#  description :text
#

class Accreditation < ActiveRecord::Base

  translates :name, :description

  has_many :accreditations_courses, dependent: :delete_all
  has_many :courses, through: :accreditations_courses

  accepts_nested_attributes_for :accreditations_courses, allow_destroy: true
  accepts_nested_attributes_for :translations

  enum role: User.roles.keys

  validates :name, presence: true
  validates :role, presence: true

  def self.sort_by_name
    where(id: all.sort_by { |c| (c.name || '').downcase }.map(&:id))
  end

  def initialize_translations!
    ["es","en","pt"].each do |locale|
      self.translations.build(locale: locale) unless self.translations.exists?(locale: locale)
    end
  end

end
