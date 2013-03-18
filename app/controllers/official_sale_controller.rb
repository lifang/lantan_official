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
    puts "-------------------------"
    puts @sale.to_json
    @products = Product.find_by_sql(["select p.name, s.prod_num from products p left join sale_prod_relations s
        on s.product_id = p.id where s.sale_id = ?", @sale.id])
  end

  #选择框省份发生变化时
  def province_change
    options = "<option value='0'>--请选择--</option>"
    city = City.where("parent_id = ?",params[:id]).all
    
    city.each do |c|
      options << "<option value=#{c.id}>#{c.name}</option>"
    end
    render :text => options
  end
  
  #选择框城市发生变化时
  def city_change
    items = ""
    stores = Store.where("city_id = ?",params[:id]).all
    if stores.blank?
      items << "<li>对不起，该城市暂未有门店...</li>"
    else
      stores.each do |s|
        items << "<li><a href = '/stores/#{s.id}' target='_blank'>#{s.name}</a></li>"
      end
    end
    render :text => items
  end
  
  #在线预约 -选择框省份发生变化时
  def province_change_reservations
    options = "<option value='0'>--请选择--</option>"
    city = City.where("parent_id = ?",params[:id].to_i).all
    city.each do |c|
      options << "<option value=#{c.id}>#{c.name}</option>"
    end
    render :text => options
  end
  
  #在线预约 -选择框城市发生变化时
  def city_change_reservations
    items = ""
    stores = Store.where("city_id = ?",params[:id].to_i).all
    if stores.blank?
      items << "<li>对不起，该城市暂未有门店...</li>"
    else
    stores.each do |s|
      items << "<a href = '/stores/#{s.id}/reservations/new'><li value=#{s.id}>#{s.name}</li></a>"
    end
    end
    render :text => items
  end
  
end
