class CoursesController < ApplicationController
  before_action :authenticate_admin!
  def index
    @courses = Course.all
    # byebug
  end

  def new
    @course = Course.new
    render
  end

  def create
    @course = Course.new(courses_params)
    if @course.save
      redirect_to courses_path
    else
      flash[:any_presence] = @course.errors[:any_presence][0]
      render :new
    end
  end

  def show
  end

  def update
  end

  def edit
  end

  def destroy
  end
  private
  def courses_params
    params.require(:course).permit(:name,:category,:description,
      :for_sales_engineer,:for_sales,:for_delivery,:session_type,:accreditation_id)    
  end
end
