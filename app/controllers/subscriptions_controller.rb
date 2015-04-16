class SubscriptionsController < ApplicationController
  def index
    @subscriptions = Subscription.where(user_id: subscription_params)
    @user_email = @subscriptions.first.user.email
  end
  private
  def subscription_params
    params[:user_id]
  end
end