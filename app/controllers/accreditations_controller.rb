class AccreditationsController < ApplicationController
  before_action :set_accreditation, only: [:destroy, :update, :edit]

  def index
    @accreditations = Accreditation.all
  end

  def new
    @accreditation = Accreditation.new
  end

  def create
    @accreditation = Accreditation.new(accreditation_params)
    if @accreditation.save
      flash[:notice] = "Acreditación creada"
      redirect_to accreditations_path
    else
      flash[:error] = "Existen algunos errores"
      render :new
    end
  end

  def update
    if @accreditation.update(accreditation_params)
      flash[:notice] = "Acreditación actualizada"
      redirect_to accreditations_path
    else
      flash[:error] = "Existen algunos errores"
      render :edit
    end
  end

  def edit
  end

  def destroy
    @accreditation.destroy
    flash[:notice] = "La acreditación fue borrada"
    redirect_to accreditations_path
  end

  protected

  def set_accreditation
    @accreditation = Accreditation.find(params[:id])
  end

  def accreditation_params
    params.require(:accreditation).permit(:name,:role,
      accreditations_courses_attributes:[ :course_id, :_destroy, :id ])
  end
end
