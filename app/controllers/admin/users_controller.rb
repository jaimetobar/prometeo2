class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    if((@q = params[:q]) && !@q.blank?)
      @users = @users.search(@q)
    end
    if((@country = params[:country]) && !@country.blank?)
      @users = @users.where(country: @country.upcase)
    end
    respond_to do |format|
      format.html do
        @users = @users
          .paginate(page: params[:page], per_page: params[:per_page] || 10)
          .order('email DESC')
      end
      format.csv do
        # Email- nombre - Curso - Status - Partner - Pais - Acreditación
        headers['Content-Disposition'] = "attachment; filename=\"user-list.csv\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end

  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end


  def create
    @user = User.new(user_params)
    if @user.save
     redirect_to admin_users_path, notice: I18n.t(".user_created",scope: @i18n_scope)
    else
     render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: I18n.t(".user_updated",scope: @i18n_scope)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy

    redirect_to admin_users_path, notice: I18n.t(".user_deleted",scope: @i18n_scope)
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email,:country,:partner,:role,:name)
  end

end
