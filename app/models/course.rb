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
#  duration           :decimal(, )
#  external_id        :string(255)
#

class Course < ActiveRecord::Base
  enum category: [:platform,:middleware,:cloud]
  enum session_type: [:always_available,:per_session]

  translates :name, :description

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :category, presence: true
  validates :session_type, presence: true
  validates :duration, presence: true
  validates :external_id, uniqueness: true

  validate :validate_presence_of_roles

  has_many :accreditations_courses, dependent: :delete_all
  has_many :accreditations, through: :accreditations_courses
  has_many :course_sessions, dependent: :delete_all
  has_many :subscriptions, dependent: :delete_all
  has_many :users, through: :subscriptions
  has_many :course_products
  has_many :products, through: :course_products

  alias_method :sessions, :course_sessions

  accepts_nested_attributes_for :accreditations_courses, allow_destroy: true
  accepts_nested_attributes_for :course_sessions, allow_destroy: true
  accepts_nested_attributes_for :translations

  def self.by_accreditations(accreditations_ids)
    joins(:accreditations_courses)
      .where("accreditations_courses.accreditation_id" => accreditations_ids).uniq
  end

  def self.sessions_per_course(courses)
    sessions_per_course = {}
    sessions = []
    courses.each do |c|
      s = c.sessions.upcoming.find do |s|
        !s.overlaps?(sessions)
      end
      unless s.nil?
        sessions_per_course[c] = s
        sessions << s
      end
    end
    sessions_per_course
  end

  def self.sort_by_name
    where(id: all.sort_by { |c| (c.name || '').downcase }.map(&:id))
  end

  def roles
    rs = []
    rs << :sales_engineer if self.for_sales_engineer
    rs << :sales if self.for_sales
    rs << :delivery if self.for_delivery
    rs
  end

  def which_roles
    self.roles.map(&:to_s).map(&:humanize).join("\n")
  end

  def next_session
    self.sessions.where("start_date > ?",DateTime.now).first
  end

  def initialize_translations!
    Settings.locales.each do |locale|
      self.translations.build(locale: locale) unless self.translations.exists?(locale: locale)
    end
  end

  protected
    def validate_presence_of_roles
      errors.add(:roles,"You must fill in at least one role") if self.roles.empty?
    end

end
