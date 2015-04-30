class PlanController < ApplicationController

  def index
  end

  # GET /plan/step_1_roles
  def step_1_roles
  end

  # GET /plan/step_2_accreditation
  def step_2_accreditations
    @role = params[:role]
    @accreditations = Accreditation.where(role: Accreditation.roles[@role])
  end

  # GET /plan/step_3_schedule
  def step_3_schedule
    @accreditations_ids = params[:accreditations]
    byebug
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
