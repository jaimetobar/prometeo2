class Admin::ProductsController < Admin::AdminController

  before_action :set_product, only: [:update, :edit, :destroy]
  def index
    @products = Product.all

    @products = @products
      .paginate(page: params[:page], per_page: params[:per_page] || 10)
      .order(category: :asc, name: :asc)
  end

  def destroy
    @product.destroy
    redirect_to admin_products_path, notice: 'Producto eliminado'
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to admin_products_path, notice: 'Producto creado'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to admin_products_path, notice: 'Producto actualizado'
    else
      render :edit
    end
  end

  private

    def product_params
      params.require(:product).permit(:name, :category)
    end

    def set_product
      @product = Product.find(params[:id])
    end
end
