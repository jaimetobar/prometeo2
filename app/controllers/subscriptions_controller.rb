class SubscriptionsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @subscriptions = Subscription.where(user: @user).order('id asc')
  end

  def multiple
    Subscription.update_multiple(params[:user_id],params[:notifications_on],params[:finished])

    redirect_to user_subscriptions_path
  end

  protected
  def subscription_params
    params.required(:subscription).permit(:id,:user_id)
  end
end
