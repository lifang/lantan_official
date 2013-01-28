#encoding: utf-8
class ProductsController < ApplicationController
  layout 'frontdoor'
  def productAndService
    @service = Product.find_all_by_is_service(1)
    @products = Product.find_all_by_is_service(0)
  end
  def productAndServiceDetail
    @serviceOrProduct = Product.find(params[:id])
  end
end
