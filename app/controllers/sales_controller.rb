#encoding: utf-8
class SalesController < ApplicationController
  layout "frontdoor"
  def index
    @title = "活动"
    @store_id = params[:store_id]
    @store = Store.find(@store_id)
    @sales = show_sale(@store_id)
    @laster_sales =  @store.sales.find_by_sql("select * from sales where status = 1  order by started_at desc  limit 2")
  end
  
  def show
    @title = "活动详情"
    store_id =params[:store_id]
    @sale = Sale.find(params[:id])
    @store = Store.find(store_id)
    @product= @sale.sale_prod_relations.first.product
    if @sale.disc_types == 1#打折
      @discount_price = discount_price(@product.base_price,@sale.discount)
    elsif @sale.disc_types == 0#金额
      @discount_price = @product.base_price - @sale.discount
    end
    @laster_sales = Sale.find_by_sql("select * from sales where status = 1 and  store_id= #{store_id} order by started_at desc  limit 2")
  end

  private
  def show_sale(store_id)#门店所有活动
    Sale.where("status = 0 and (store_id = ? or store_id = 1)",store_id).paginate(
      :page => params[:page],:per_page => 3,:order => "created_at desc")
  end

  def discount_price(sale_price,discount)
    sale_price*(discount/10)
  end
end
