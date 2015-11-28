class PagesController < ApplicationController
  before_action :set_active_menu_tab

  def home
  end

  def docs
  end

  def presentations
  end

  def start
  end

  protected

  def set_active_menu_tab
    @active_menu_tab = params[:action]
  end

end
