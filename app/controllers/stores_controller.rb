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
    @laster_sales =  Sale.find_by_sql("select * from sales where store_id = #{store_id} and status = 1 order by started_at desc  limit 2")
    #门店服务
    @product_service = Product.where("is_service=? and status = 1",1).all
    #门店产品
    @product_product = Product.where("is_service=? and status = 1",0).all
  end

  private
  #门店所有产品服务类型
  def all_products(store_id)
    Product.find_product_by_store_id(store_id)
  end
end
