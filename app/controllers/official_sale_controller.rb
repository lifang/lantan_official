#encoding: utf-8
class OfficialSaleController < ApplicationController  #总店活动促销页面
  layout "headquarter"

  #官网活动促销
  def index
    @sales = Sale.paginate_by_sql(["select * from sales where status = ? order by created_at desc ", Sale::STATUS[:RELEASE]],
      :page => params[:page],:per_page => Sale::SALES_PER_PAGE_NUM)
  end

  #官网活动促销详情
  def show
    @sale = Sale.find(params[:id])
    @products = Product.find_by_sql(["select p.name, s.prod_num from products p left join sale_prod_relations s
        on s.product_id = p.id where s.sale_id = ?", @sale.id])
  end

  #选择框省份发生变化时
  def province_change
    @cities = params[:id].eql?("0") ? [] : City.where("parent_id = #{params[:id]}")
    @common = params[:common] if params.keys.include?('common')
  end
  
  #选择框城市发生变化时
  def city_change
    @stores = SStore.where("city_id = #{params[:id]} and status = #{Store::STATUS[:OPENED]}")
    @common = params[:common] if params.keys.include?('common')
  end
  
end
