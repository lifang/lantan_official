class ProductInformationController < ApplicationController  #产品信息
  layout 'headquarter'
  def index
    @products = Product.find_all_by_is_service(Product::IS_SERVICE[:NO]).paginate(
      :page => params[:page],:per_page => 3,:order => "created_at desc")
  end

  def show
    @product = Product.find(params[:id])
    @image_urls = @product.image_urls
  end
end
