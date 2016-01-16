# == Schema Information
#
# Table name: accreditations
#
#  id         :integer          not null, primary key
#  created_at :datetime
#  updated_at :datetime
#  role       :integer
#  tags       :string(255)
#  category   :integer
#  advanced   :boolean          default(FALSE)
#

class Accreditation < ActiveRecord::Base

  translates :name, :description

  enum category: [:platform,:middleware,:cloud]

  has_many :accreditations_courses, dependent: :delete_all
  has_many :courses, through: :accreditations_courses
  has_many :accreditation_suggestions, dependent: :delete_all
  has_many :suggestions, through: :accreditation_suggestions

  accepts_nested_attributes_for :accreditations_courses, allow_destroy: true
  accepts_nested_attributes_for :translations
  accepts_nested_attributes_for :accreditation_suggestions, allow_destroy: true

  enum role: User.roles.keys

  validates :name, presence: true
  validates :role, presence: true

  after_initialize :defaults

  scope :advanced, -> { where(advanced: true) }

  def self.suggestions_for(accreditations_ids)
    ids = AccreditationSuggestion.where(accreditation_id: accreditations_ids).pluck(:suggestion_id)
    Accreditation.where(id: ids)
  end

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
      self.advanced ||= false
      self.tags ||= ""
    end
end
