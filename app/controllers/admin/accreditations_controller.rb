class Admin::AccreditationsController < Admin::AdminController
  before_action :set_accreditation, only: [:destroy, :update, :edit]

  def index
    @accreditations = Accreditation.sort_by_name

    if @course = Course.find_by_id(params[:course])
      @accreditations = @accreditations
        .joins(:accreditations_courses)
        .where("accreditations_courses.course_id = ?",@course.id)
    end
  end

  def new
    @accreditation = Accreditation.new
    @accreditation.initialize_translations!
  end

  def create
    @accreditation = Accreditation.new(accreditation_params)
    if @accreditation.save
      flash[:notice] = "Acreditación creada"
      redirect_to admin_accreditations_path
    else
      flash[:error] = "Existen algunos errores"
      render :new
    end
  end

  def update
    if @accreditation.update(accreditation_params)
      flash[:notice] = "Acreditación actualizada"
      redirect_to admin_accreditations_path
    else
      flash[:error] = "Existen algunos errores"
      render :edit
    end
  end

  def edit
    @accreditation.initialize_translations!
  end

  def destroy
    @accreditation.destroy
    flash[:notice] = "La acreditación fue borrada"
    redirect_to admin_accreditations_path
  end

  protected

  def set_accreditation
    @accreditation = Accreditation.find(params[:id])
  end

  def accreditation_params
    params.require(:accreditation).permit(
      :name,:role,:description,:tags,:category,:advanced,:is_certification,
      accreditations_courses_attributes:[ :course_id, :_destroy, :id ],
      translations_attributes: [:id, :locale, :name, :description],
      accreditation_suggestions_attributes:[ :suggestion_id, :_destroy, :id ]
    )
  end
end
