class PlanController < ApplicationController

  before_action :set_role_and_accreditations, only: [:step_2_accreditations,:step_3_schedule,:step_4_subscription,:create]
  before_action :set_accreditations_ids, only: [:step_3_schedule,:step_4_subscription,:create]
  before_action :set_navigation

  # GET /plan
  def index
  end

  # GET /plan/step_1_roles
  def step_1_roles
    render :index
  end

  # GET /plan/step_2_accreditation
  def step_2_accreditations
  end

  # GET /plan/step_3_schedule
  def step_3_schedule

    if @accreditations_ids.nil? || @accreditations_ids.empty?
      flash.now[:alert] = I18n.t("plan.step_3_schedule.at_least_one_accreditation")
      render :step_2_accreditations
    else
      @courses = Course.by_accreditations(@accreditations_ids)

      subscription_attributes = Subscription.attributes_from_courses_and_role(@courses,@role)

      @user = User.new(role: @role, subscriptions_attributes: subscription_attributes)

      @sessions_per_course = Course.sessions_per_course(@courses)

    end
  end

  def step_4_subscription

    courses = Course.by_accreditations(@accreditations_ids)
    @hours_count = courses.uniq.sum(:duration)
    @accreditations_count = @accreditations_ids.length

    subscription_attributes = Subscription.attributes_from_courses_and_role(courses,@role)
    @user = User.new(role: @role, subscriptions_attributes: subscription_attributes)
  end

  # POST /plan
  def create
    @user = User.new(user_params)
    if @user.save
      PlanMailer.delay.plan_greatings_email(@user)
      redirect_to root_path, notice: I18n.t("plan.create.subscribed")
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
      subscriptions_attributes: [:course_id,:accreditation_id]
    )
  end

  def set_role_and_accreditations
    @role = params[:role]
    @accreditations = Accreditation.where(role: Accreditation.roles[@role])
  end

  def set_accreditations_ids
    @accreditations_ids = params[:accreditations]
  end

  def set_navigation
    @admin_navigation = false
    @active_menu_tab = "plan"
  end

end
