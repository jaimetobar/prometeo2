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
    @role = params[:role]
    accreditations_ids = params[:accreditations]
    courses = Course.joins(:accreditations_courses)
      .where("accreditations_courses.accreditation_id" => accreditations_ids).uniq

    @plan = Plan.new(courses: courses)
    
  end

  protected

  def plan_params
    params
      .require(:plan)
      .permit(courses:[])
  end
end
