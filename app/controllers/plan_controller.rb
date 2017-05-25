class PlanController < ApplicationController

  before_action :set_role_and_accreditations, only: [:step_2_accreditations,:step_3_schedule,:step_4_subscription,:new_or_update_form,:create,:add_suggestion]
  before_action :set_accreditations_ids, only: [:step_3_schedule,:step_4_subscription,:new_or_update_form,:create,:add_suggestion]
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
      @suggestions = Accreditation.suggestions_for(@accreditations_ids).where("is_certification = ? OR advanced = ?",true,true)
      subscription_attributes = Subscription.attributes_from_courses_and_role(@courses,@role)

      @user = User.new(role: @role, subscriptions_attributes: subscription_attributes)

      @sessions_per_course = Course.sessions_per_course(@courses)

    end
  end

  def step_4_subscription
    courses = Course.by_accreditations(@accreditations_ids)
    @hours_count = courses.uniq.sum(:duration)
    @accreditations_count = Accreditation.where(id: @accreditations_ids).where("is_certification = ?",false).count
    @certifications_count = Accreditation.where(id: @accreditations_ids).certification.count

    subscription_attributes = Subscription.attributes_from_courses_and_role(courses,@role)
    @user = User.new(role: @role, subscriptions_attributes: subscription_attributes)
  end

  def new_or_update_form
    email = params[:user][:email]
    courses = Course.by_accreditations(@accreditations_ids)
    @hours_count = courses.uniq.sum(:duration)
    @accreditations_count = @accreditations_ids.length

    @user = User.find_by_email(email)
    if @user
      courses = courses.where.not(id: @user.subscriptions.pluck(:course_id))
      subscriptions_attributes = Subscription.attributes_from_courses_and_role(courses,@role)
      @user.update(subscriptions_attributes: subscriptions_attributes)
      flash[:notice] = I18n.t('plan.create.subscribed')
      flash.keep(:notice)
      render :updated
      PlanMailer.delay.plan_greatings_email(@user)
      PlansNotifier.notify_update(@user)
    elsif EmailValidator.valid?(email)
      subscriptions_attributes = Subscription.attributes_from_courses_and_role(courses,@role)
      @user = User.new(role: @role, subscriptions_attributes: subscriptions_attributes, email: email)
      render :new
    else
      @user = User.new(email: email)
      @user.valid?
      render :invalid_email
    end
  end


  # POST /plan
  def create
    @user = User.new(user_params)
    if @user.save
      PlanMailer.delay.plan_greatings_email(@user)
      PlansNotifier.notify_create(@user)
      redirect_to root_path, notice: I18n.t("plan.create.subscribed")
    else
      render :step_4_subscription
    end
  end

  # GET /entrenamiento/add_suggestion
  def add_suggestion
    @accreditation = Accreditation.find(params[:id])
    @courses = Course.by_accreditations(@accreditations_ids)
    @accreditations_ids = @accreditations_ids + [@accreditation.id]
    @sessions_per_course = Course.sessions_per_course(@courses)
  end

  protected

    def plan_params
      params
        .require(:plan)
        .permit(courses:[])
    end

    def user_params
      params.require(:user).permit(
        :email,:country,:partner_name,:role,:name,
        subscriptions_attributes: [:course_id,:accreditation_id]
      )
    end

    def set_role_and_accreditations
      @role = params[:role]
      @accreditations = Accreditation
        .where(role: Accreditation.roles[@role])
        .where(advanced: false)
        .where(is_certification: false)
    end

    def set_accreditations_ids
      @accreditations_ids = params[:accreditations]
    end

    def set_navigation
      @admin_navigation = false
      @active_menu_tab = "plan"
    end

end
