#encoding: utf-8
class ProductsController < ApplicationController    #产品与服务
  layout 'frontdoor'
  def index     #产品&服务
    @store = SStore.find_by_id(params[:store_id].to_i)
    all_products = SProduct.find(:all, :select => "id, name, types, img_url, is_service",
      :conditions => ["status = ? and store_id = ?", Product::STATUS[:NOMAL], params[:store_id].to_i]).group_by{ |t| t.is_service }
    @services = all_products[SProduct::IS_SERVICE_VALUE[:YES]].group_by{ |t| t.types } if all_products and
      all_products[SProduct::IS_SERVICE_VALUE[:YES]]
    @products = all_products[SProduct::IS_SERVICE_VALUE[:NO]] if all_products
  end

  def show    #单个产品显示
    @store = SStore.find_by_id(params[:store_id].to_i)
    @product = SProduct.find_by_id(params[:id].to_i)
    @img_urls = SImageUrl.find(:all, :conditions => ["product_id = ?", @product.id])
  end

end