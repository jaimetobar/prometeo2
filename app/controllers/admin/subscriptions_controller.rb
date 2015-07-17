class Admin::SubscriptionsController < Admin::AdminController

  # GET /admin/users/:id/subscriptions
  def index
    @user = User.find(params[:user_id])
  end

  # GET /admin/users/:id/subscriptions/print
  def print
    @user = User.find(params[:user_id])
    render layout: false
  end

  # PATCH /admin/users/:id/subscriptions
  def update_user_subscriptions
    @user = User.find(params[:user_id])
    @user.update(user_params)
    redirect_to admin_users_path
  end

  protected
  def user_params
    params.require(:user).permit(
      subscriptions_attributes: [:id, :notifications_on, :finished]
    )
  end

  def set_navigation
    super
    @active_menu_tab = "admin-users"
  end

end
