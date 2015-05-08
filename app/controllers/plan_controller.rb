class PlanController < ApplicationController

  def index
  end

  # GET /plan/step_1_roles
  def step_1_roles
    render :index
  end

  # GET /plan/step_2_accreditation
  def step_2_accreditations
    @role = params[:role]
    @accreditations = Accreditation.where(role: Accreditation.roles[@role])
  end

  # GET /plan/step_3_schedule
  def step_3_schedule
    @role = params[:role]
    @accreditations_ids = params[:accreditations]
    @accreditations = Accreditation.where(role: Accreditation.roles[@role])
    if @accreditations_ids.nil? || @accreditations_ids.empty?
      flash.now[:alert] = "Selecciona por lo menos una acreditación"
      render :step_2_accreditations
    else
      courses = Course.joins(:accreditations_courses)
        .where("accreditations_courses.accreditation_id" => @accreditations_ids).uniq

      @plan = Plan.new(courses: courses)
    end
  end

  def step_4_subscription
    @role = params[:role]
    @accreditations_ids = params[:accreditations]

    courses = Course.joins(:accreditations_courses)
      .where("accreditations_courses.accreditation_id" => @accreditations_ids).uniq

    @user = User.new(role: @role, subscriptions_attributes: courses.map { |c| { course_id: c.id} } )
  end

  # POST /plan
  def create
    @role = params[:role]
    @accreditations_ids = params[:accreditations]

    @user = User.new(user_params)
    byebug
    if @user.save
      #PlanMailer.plan_greatings_email(@user).deliver
      redirect_to :index, notice: "Te avisaremos cuando los cursos vayan a comenzar"
    else
      render :step_4_subscription
    end
  end

  protected

  def plan_params
    params
      .require(:plan)
      .permit(courses:[])
  end

  def user_params
    params.require(:user).permit(
      :email,:country,:partner,:role,:name,
      subscriptions_attributes: [:course_id]
    )
  end
end
