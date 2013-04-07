#encoding: utf-8
class SalesController < ApplicationController
  layout "frontdoor"
  
  #门店活动促销首页
  def index
    @store = SStore.find_by_id(params[:store_id].to_i)
    @sales = SSale.find(:all, :conditions =>["status = ?  and store_id = ?",
        SSale::STATUS[:RELEASE], @store.id]).paginate(:page => params[:page],
      :per_page => SSale::SALES_PER_PAGE_NUM,:order => "created_at desc")
  end

  #门店活动详情
  def show
    @store = SStore.find_by_id(params[:store_id].to_i)
    @sale = SSale.find_by_id(params[:id].to_i)
    @products = SProduct.find_by_sql(["select p.name, s.prod_num from lantan_db_all.products p
        left join lantan_db_all.sale_prod_relations s
        on s.product_id = p.id where s.sale_id = ?", @sale.id])
  end

  #门店活动产品/服务，价格计算
  def discount_price(sale_price,discount)
    sale_price*(discount/10)
  end
end
