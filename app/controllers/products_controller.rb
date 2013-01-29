#encoding: utf-8
class ProductsController < ApplicationController
  layout 'frontdoor'
  def index
    @store = Store.find(params[:store_id].to_i)
    services = Product.find_all_by_is_service_and_store_id(Product::IS_SERVICE[:YES],params[:store_id])
    @service_hash = {}
    services.each do |s|
      if @service_hash[s.types]

      else
        
      end
    end
    @products = Product.find_all_by_is_service_and_store_id(Product::IS_SERVICE[:NO],params[:store_id])
  end

  def show
    @product = Product.find(params[:id])
    @store = Store.find(@product.store_id)
  end
end
