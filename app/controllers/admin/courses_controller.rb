class Admin::CoursesController < Admin::AdminController
  before_action :set_course, only: [:destroy, :update, :edit]

  def index
    @courses = Course.all.sort_by { |c| (c.name || '').downcase }
    if @accreditation = Accreditation.find_by_id(params[:accreditation])
      @courses = @courses
        .joins(:accreditations_courses)
        .where("accreditations_courses.accreditation_id = ?",@accreditation.id)
    end
  end

  def new
    @course = Course.new
    ["es","en","pt"].each do |locale|
      @course.translations.build(locale: locale) unless @course.translations.exists?(locale: locale)
    end
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:notice] = "Curso creado"
      redirect_to admin_courses_path
    else
      flash[:roles] = @course.errors[:roles][0]
      render :new
    end
  end

  def edit
    ["es","en","pt"].each do |locale|
      @course.translations.build(locale: locale) unless @course.translations.exists?(locale: locale)
    end
  end

  def update
    if @course.update(course_params)
      redirect_to admin_courses_path
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to admin_courses_path
  end


  private
    def set_course
      @course = Course.find(params[:id])
    end
    def course_params
      params.require(:course).permit(
        :name,:category,:description,:for_sales_engineer,:for_sales,:for_delivery,:session_type,:duration,
        accreditations_courses_attributes:[ :accreditation_id, :_destroy, :id ],
        course_sessions_attributes:[ :start_date, :end_date, :_destroy, :id ],
        translations_attributes: [:id, :locale, :name, :description]
      )
    end
end
