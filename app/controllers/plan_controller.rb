class PlanController < ApplicationController
  def index
  end

  # GET /plan/courses/:role
  def courses
    @role = params[:role]
    @courses = Course.where(role: Course.roles[@role])
  end
end
