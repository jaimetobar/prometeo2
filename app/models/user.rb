# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  email        :string(255)
#  country      :string(255)
#  partner_name :string(255)
#  role         :integer
#  created_at   :datetime
#  updated_at   :datetime
#  email_token  :string(255)
#  name         :string(255)
#  partner_id   :integer
#

class User < ActiveRecord::Base

  enum role: [:sales_engineer,:sales,:delivery]

  belongs_to :partner
  has_many :subscriptions
  has_many :courses, -> { uniq }, through: :subscriptions
  has_many :accreditations, -> { uniq }, through: :subscriptions

  validates :email, presence: true, uniqueness: { case_sensitive: false }, email: true
  validates :country, presence: true, inclusion: { in: ISO3166::Country.all.map { |name, code| code } }
  validates :partner_name, presence: true
  validates :role, presence: true
  validates :name, presence: true

  before_create :add_token

  accepts_nested_attributes_for :subscriptions
  scope :search, ->(q) do
    query_string = q.split.join('%')
    where(%Q(
      LOWER(UNACCENT(name)) LIKE LOWER(UNACCENT(:q)) OR
      LOWER(UNACCENT(email)) LIKE LOWER(UNACCENT(:q)) OR
      LOWER(UNACCENT(partner_name)) LIKE LOWER(UNACCENT(:q))
    ),q: "%#{query_string}%")
  end

  def self.notify_upcoming_courses(start_date,opts={})
    delay = opts[:delay] || true
    courses_sessions = CourseSession.where("start_date = :start_date", start_date: start_date)

    courses = Course.joins(:course_sessions).where("course_sessions.id" => courses_sessions.pluck(:id)).uniq
    courses_ids = courses.pluck(:id)
    users = User.joins(:subscriptions).where("subscriptions.course_id" => courses.pluck(:id)).uniq

    users.each do |u|
      # TODO:
      # I'm collectiong ids because there's something that fails with sidekik
      # when I try to send the subscriptions as an ActiveRecord Asociation.
      # I guess that it has to do with serialization of the object
      user_subscriptions_ids = u.subscriptions.where(course_id: courses_ids, notifications_on: true).pluck :id
      unless user_subscriptions_ids.empty?
        begin
          if delay
            PlanMailer.delay.upcoming_courses_email(u, user_subscriptions_ids, start_date)
          else
            PlanMailer.upcoming_courses_email(u, user_subscriptions_ids, start_date).deliver
          end
          Rails.logger.info "Notification email sent to: #{ u.email }, start at: #{start_date}"
        rescue
          Rails.logger.error "Notification email failed. Not sent to: #{ u.email }, start at: #{start_date}"
        end
      end

    end
  end

  def locale
    case self.country
    when 'BR'
      'pt'
    when 'MX'
      'es-MX'
    when 'CN'
      'zh'
    when 'JP'
      'jp'
    when 'KP','KR'
      'kr'
    else
      southamerican_countries = ISO3166::Country.find_all_by(:subregion,'South America')
      if southamerican_countries.include? self.country
        'es'
      end
    end
  end

  private
    def add_token
      begin
        self.email_token = SecureRandom.urlsafe_base64(64)
      end while User.exists?(email_token: self.email_token)
    end
end
