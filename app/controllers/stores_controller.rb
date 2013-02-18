#encoding: utf-8
class StoresController < ApplicationController  #门店控制器
  layout "frontdoor" #门店模板
  
  #首页,展示门店
  def show
    #当前门店
    store_id = params[:id].to_i
    begin
      @store = Store.find(store_id)#寻找门店失败
    rescue
     redirect_to "/500"#重定向到错误页面
    else
      #最新活动
      @laster_sales = Sale.find(:all,
        :conditions => ["store_id = ? and status = ? ",store_id,
          Sale::STATUS[:NOMAL]],
        :order=>"started_at desc", :limit => Sale::LASTER_SALES)
      #门店服务
      @services = Product.find(:all,
        :conditions => ["is_service = ? and store_id = ? ",Product::IS_SERVICE[:YES],
          params[:id].to_i])
      #门店产品
      @products = Product.find(:all,
        :conditions => ["is_service = ? and store_id = ? ",Product::IS_SERVICE[:NO],
          params[:id].to_i])
    end
  end
end
