#encoding: utf-8
class ProductsController < ApplicationController    #产品与服务
  layout 'frontdoor'
  def index     #产品&服务
    @store = Store.find(params[:store_id])
    services = SProduct.find(:all, :conditions => ["is_service = ? and store_id = ?", Product::IS_SERVICE[:YES], params[:store_id]])
    @service_hash = {}
    Product::SERVICE_TYPES.each_key do |key|  #将Product类里面的服务类别迭代并将Products表中的数据按类别划分
      services.each do |service|
        if(service.types == key)
          if @service_hash[key].nil?
             @service_hash[key] = []     
             @service_hash[key] << service
          else
            @service_hash[key] << service
          end
        end
      end
    end
    @products = Product.find_all_by_is_service_and_store_id(Product::IS_SERVICE[:NO],
      params[:store_id])
    @laster_sales = Sale.find(:all,
      :conditions => ["store_id = ? and status =?",@store.id,Sale::STATUS[:NOMAL]],
      :order=>"started_at desc", :limit => Sale::LASTER_SALES)
  end

  def show    #单个产品显示
    @service_or_product = Product.find(params[:id])
    @store = Store.find(@service_or_product.store_id)
    @laster_sales = Sale.find(:all,
      :conditions => ["store_id = ? and status =?",@store.id,Sale::STATUS[:NOMAL]],
      :order=>"started_at desc", :limit => Sale::LASTER_SALES)
  end
end
