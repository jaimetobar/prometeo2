class Admin::AdminController < ApplicationController
  before_action :set_navigation

  protected

  def set_navigation
    @admin_navigation = true
    # admin/courses -> admin-courses
    @active_menu_tab = params[:controller].sub("/","-")
  end
end
