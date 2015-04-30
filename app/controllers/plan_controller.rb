class PlanController < ApplicationController
  def index
  end

  # GET /plan/courses/:role
  def courses
    @role = params[:role]
    Course.where("for_#{@role}" => true)
  end

  # POST /plan
  def create
    @plan = Plan.new(courses: Course.where(id: plan_params[:courses]))
  end

  protected

  def plan_params
    params
      .require(:plan)
      .permit(courses:[])
  end
end
