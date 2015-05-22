class AdminsController < ApplicationController

  def index
    @admins = Admin.all
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    @admin.password = "password"
    if @admin.create
      flash[:alert] = "Admin creado. Se le notificara por correo para que active su cuenta"
      #TODO: enviar correo
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

  protected

  def admin_params
    params.require(:admin).permit(:email)
  end
end
