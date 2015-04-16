# Virtual Model that represents a plan
class Plan
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :sessions, :courses, :sessions_per_course

  validates_presence_of :courses

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
    self.build_plan
  end

  def persisted?
    false
  end

  protected

  def build_plan
    self.sessions_per_course = {}
    self.sessions = []
    self.courses.each do |c|
      self.sessions_per_course[c] = nil
      if c.per_session?
        s = c.sessions.upcoming.find do |s|
          !s.overlaps?(self.sessions)
        end
        unless s.nil?
          self.sessions_per_course[c] = s
          self.sessions << s
        end
      end
    end
  end

end
