class Admin::PartnersController < Admin::AdminController
  before_action :set_partner, only: [:show, :edit, :update, :destroy]

  def index
    @partners = Partner.all

    @partners = @partners
      .paginate(page: params[:page], per_page: params[:per_page] || 10)
      .order(:name)
  end

  def show
  end

  def new
    @partner = Partner.new
  end

  def edit
  end


  def create
    @partner = Partner.new(partner_params)
    if @partner.save
     redirect_to admin_partners_path, notice: 'Partner creado'
    else
     render :new
    end
  end

  def update
    if @partner.update(partner_params)
      redirect_to admin_partners_path, notice: 'Partner actualizado'
    else
      render :edit
    end
  end

  def destroy
    @partner.destroy

    redirect_to admin_partners_path, notice: 'Partner eliminado'
  end

  private
    def set_partner
      @partner = Partner.find(params[:id])
    end

    def partner_params
      params.require(:partner).permit(
        :name,:account_id,
        contacts_attributes:[ :first_name, :last_name, :email, :_destroy, :id ]
      )
    end

end
