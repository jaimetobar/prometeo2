class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    if((@q = params[:q]) && !@q.blank?)
      @users = @users.search(@q)
    end
    if((@country = params[:country]) && !@country.blank?)
      @users = @users.where(country: @country.upcase)
    end
    respond_to do |format|
      format.html do
        @users = @users
          .paginate(page: params[:page], per_page: params[:per_page] || 10)
          .order('email DESC')
      end
      format.csv do
        # Email- nombre - Curso - Status - Partner - Pais - Acreditación
        headers['Content-Disposition'] = "attachment; filename=\"user-list.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end

  end

  # GET /users/notifications/:email_token
  def edit_notifications
    @user = User.find_by_email_token(params[:email_token])
    @email_token = params[:email_token]
    raise ActionController::RoutingError.new('Not Found') unless @user

  end

  # PATCH /users/notifications/:email_token
  def update_notifications
    @user = User.find_by_email_token(params[:email_token])
    @email_token = params[:email_token]
    raise ActionController::RoutingError.new('Not Found') unless @user
    if @user.update(notifications_params)
      flash[:notice] = "Tus preferencias de notificaciones fueron actualizadas"
      redirect_to notifications_users_path(@email_token)
    else
      flash[:alert] = "Hubo errores actualizando las preferencias. Intenta de nuevo."
      render :edit_notifications
    end

  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end


  def create
    @user = User.new(user_params)
    if @user.save
     redirect_to :index, notice: 'Te has inscrito correctamente'
    else
     render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'Usuario Actualizado correctamente'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy

    redirect_to users_url, notice: 'Usuario ha sido borrado correctamente'
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email,:country,:partner,:role,:name)
    end

    def notifications_params
      params.require(:user).permit(
        subscriptions_attributes: [:id, :notifications_on]
      )
    end
end
