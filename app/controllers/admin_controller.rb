class AdminController < ApplicationController
  def index
    if admin_signed_in?
      redirect_to courses_path
    else
      render "index"
    end
  end
end
