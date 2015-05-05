class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end
  
  def token
  end

  def create
    @user = User.new(user_params)
    if @user.save
     PlanMailer.plan_greatings_email(@user).deliver
     redirect_to  root_path, notice: 'Te has inscrito correctamente'
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
   
    redirect_to users_url, notice: 'Usuario ah sido borrado correctamente' 
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit([:email,:country,:partner,:role])
    end
end
