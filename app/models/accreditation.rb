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

class Accreditation < ActiveRecord::Base

  translates :name, :description

  enum category: [:platform,:middleware,:cloud]

  has_many :accreditations_courses, dependent: :delete_all
  has_many :courses, through: :accreditations_courses

  accepts_nested_attributes_for :accreditations_courses, allow_destroy: true
  accepts_nested_attributes_for :translations

  enum role: User.roles.keys

  validates :name, presence: true
  validates :role, presence: true

  after_initialize :defaults

  def self.sort_by_name
    where(id: all.sort_by { |c| (c.name || '').downcase }.map(&:id))
  end

  def initialize_translations!
    Settings.locales.each do |locale|
      self.translations.build(locale: locale) unless self.translations.exists?(locale: locale)
    end
  end

  def tag_list
    self.tags.split(",").map(&:strip)
  end

  private
    def defaults
      self.tags ||= ""
    end
end
