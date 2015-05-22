class AdminsController < ApplicationController

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
      flash[:notice] = "Admin creado. Se le notificara por correo para que active su cuenta"
      redirect_to :back
    else
      render :index
    end
  end

  def destroy
    @admin = Admin.find(params[:id])
    if @admin == current_admin
      flash[:alert] = "No puedes eliminar tu propia cuenta"
      redirect_to :back
    else
      @admin.destroy
      flash[:notice] = "Cuenta eliminada"
      redirect_to :back
    end
  end

  def email_password_reset
    @admin = Admin.find(params[:id])
    @admin.send_reset_password_instructions
    flash[:notice] = "Se ha enviado un correo para que el usuario configure una contraseña"
    redirect_to :back
  end

  protected

  def admin_params
    params.require(:admin).permit(:email)
  end
end
