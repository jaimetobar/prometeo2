class Admin::AdminsController < Admin::AdminController

  def index
    @admins = Admin.all
    @admin = Admin.new
  end

  def create
    @admins = Admin.all
    @admin = Admin.new(admin_params)
    @admin.password = SecureRandom.hex
    if @admin.save
      @admin.send_reset_password_instructions
      flash[:notice] = I18n.t(".admin_created",scope: @i18n_scope)
      redirect_to :back
    else
      render :index
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    if @admin == current_admin
      flash[:alert] = I18n.t(".cant_delete_self_account",scope: @i18n_scope)
      redirect_to :back
    else
      @admin.destroy
      flash[:notice] = I18n.t(".account_deleted",scope: @i18n_scope)
      redirect_to :back
    end
  end

  def email_password_reset
    @admin = Admin.find(params[:id])
    @admin.send_reset_password_instructions
    flash[:notice] = I18n.t(".confirmation_email_sent",scope: @i18n_scope)
    redirect_to :back
  end

  protected

  def admin_params
    params.require(:admin).permit(:email)
  end
end
