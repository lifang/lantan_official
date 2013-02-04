#encoding: utf-8
#门店控制器
class StoresController < ApplicationController
  layout "frontdoor" #门店模板
  #首页,展示门店
  def show
    @title = "门店首页"
    #当前门店
    store_id = params[:id]
    @store = Store.find(store_id)
    
    #最新活动
    @laster_sales =  Sale.find_by_sql ["select * from sales where
store_id = ? and status = ? order by started_at desc  limit ?",store_id,
      STATUS_TRUE,LASTRT_SALES]
    #门店服务
    @product_service = Product.find_by_sql ["select * from products where 
is_service= ? and status = ?",PRODUCT_SERVICE,STATUS_TRUE]
    #门店产品
    @product_product = Product.find_by_sql ["select * from products where
is_service= ? and status = ?",PRODUCT_PRODUCT,STATUS_TRUE]
  end

  private
  #门店所有产品服务类型
  def all_products(store_id)
    Product.find_product_by_store_id(store_id)
  end
end
