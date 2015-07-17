class UsersController < ApplicationController
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

  private

  def notifications_params
    params.require(:user).permit(
      subscriptions_attributes: [:id, :notifications_on]
    )
  end
end
