require 'csv'

class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :set_i18n_scope

  private
    def set_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def default_url_options(options = {})
      { locale: I18n.locale }.merge options
    end

    def set_i18n_scope
      @i18n_scope = (params["controller"].split("/") + [params["action"]]).join(".")
    end

end
