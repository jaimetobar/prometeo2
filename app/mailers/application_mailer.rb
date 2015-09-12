class ApplicationMailer < ActionMailer::Base
  before_action :set_locale

  private
    def set_locale
      ApplicationMailer.default_url_options[:locale] = I18n.default_locale
    end
end
