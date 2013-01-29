#encoding: utf-8
class ProductsController < ApplicationController
  layout 'frontdoor'
  def index
    @service = Product.find_all_by_is_service_and_store_id(Product::IS_SERVICE[:YES],params[:store_id])
    @products = Product.find_all_by_is_service_and_store_id(Product::IS_SERVICE[:NO],params[:store_id])
  end

  def show
    @serviceOrProduct = Product.find(params[:id])
  end
end
