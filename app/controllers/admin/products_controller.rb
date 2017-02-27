class Admin::ProductsController < Admin::AdminController
  def index
    @products = Product.all

    @products = @products
      .paginate(page: params[:page], per_page: params[:per_page] || 10)
      .order(category: :asc, name: :asc)
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy

    redirect_to admin_products_path, notice: 'Producto eliminado'
  end

  private

    def product_params
      params.require(:product).permit(:name)
    end

end
