class SubscriptionsController < ApplicationController

  # GET /admin/users/:id/subscriptions
  def index
    @user = User.find(params[:user_id])
  end

  # PATCH /admin/users/:id/subscriptions
  def update_user_subscriptions
    @user = User.find(params[:user_id])
    @user.update(user_params)
    redirect_to users_path
  end

  protected
  def user_params
    params.require(:user).permit(
      subscriptions_attributes: [:id, :notifications_on, :finished]
    )
  end
end
