class Admin::AdminController < ApplicationController
  before_action :set_navigation

  def index
    redirect_to admin_courses_path
  end

  protected

  def set_navigation
    @admin_navigation = true
    # admin/courses -> admin-courses
    @active_menu_tab = params[:controller].sub("/","-")
  end
end
