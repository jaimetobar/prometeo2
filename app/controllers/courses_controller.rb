class CoursesController < ApplicationController
  before_action :set_course, only: [:destroy, :update, :edit]

  def index
    @courses = Course.all.order(:name)
    if @accreditation = Accreditation.find_by_id(params[:accreditation])
      @courses = @courses
        .joins(:accreditations_courses)
        .where("accreditations_courses.accreditation_id = ?",@accreditation.id)
    end
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:notice] = "Curso creado"
      redirect_to courses_path
    else
      flash[:roles] = @course.errors[:roles][0]
      render :new
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to courses_path
    else
      flash[:roles] = @course.errors[:roles][0]
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to courses_path
  end


  private
  def set_course
    @course = Course.find(params[:id])
  end
  def course_params
    params.require(:course).permit(
      :name,:category,:description,:for_sales_engineer,:for_sales,:for_delivery,
      :session_type,accreditations_courses_attributes:[ :accreditation_id, :_destroy, :id ])
  end
end
