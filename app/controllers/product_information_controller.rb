class ProductInformationController < ApplicationController  #产品信息
  layout 'headquarter'
  def index
    @products = Product.find_all_by_is_service_and_status(Product::IS_SERVICE[:NO], Product::STATUS[:NOMAL]).paginate(
      :page => params[:page],:per_page => 3,:order => "created_at desc")
  end

  def show
    @product = Product.find(params[:id])
    @img_urls = @product.image_urls
  end
end
