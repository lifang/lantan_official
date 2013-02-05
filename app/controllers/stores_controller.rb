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
    @laster_sales = Sale.find(:all,
      :conditions => ["store_id = ? and status = ? ",store_id,
        Sale::STATUS[:NOMAL]],
      :order=>"started_at desc", :limit => Sale::LASTER_SALES)
    #门店服务
    @product_service = Product.find(:all,
      :conditions => ["is_service = ? and status = ? ",Product::IS_SERVICE[:NO],
        Sale::STATUS[:NOMAL]])
    #门店产品
    @product_product = Product.find(:all,
      :conditions => ["is_service = ? and status = ? ",Product::IS_SERVICE[:YES],
        Sale::STATUS[:NOMAL]])
  end
end
