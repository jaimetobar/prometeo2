class SubscriptionsController < ApplicationController
  
  def index
    @subscriptions = Subscription.where(user_id: params[:user_id]).order('id asc')
    @user = Subscription.find(params[:user_id]))
  end

  def multiple
    Subscription.update_multiple(params[:user_id],params[:notifications_on],params[:finished])

    redirect_to user_subscriptions_path
  end

  private
  def subscription_params
    params.required(:subscription).permit[:id,:user_id]
  end
end