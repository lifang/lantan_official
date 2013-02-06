#encoding: utf-8
class OfficialSaleController < ApplicationController  #总店活动促销页面
  layout "headquarter"

  #官网活动促销
  def index
    @sales_laster = Sale.find(:all, :conditions => ["status = ? and store_id = ?",
        Sale::STATUS[:NOMAL],Store::DEFAULT_ID],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
    @sales=show_sales
  end

  #官网活动促销详情
  def show
    @sales_laster = Sale.find(:all, :conditions => ["status = ? and store_id = ?",
        Sale::STATUS[:NOMAL],Store::DEFAULT_ID],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
    sale_id=params[:id]
    begin
    @sale = Sale.find(sale_id)
    rescue
     redirect_to "/500"
    end
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
      items << "<a href = '/stores/#{s.id}'><li value=#{s.id}>#{s.name}</li></a>"
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
  
  private
  #官网总店的销售活动
  def show_sales
    Sale.find(:all, :conditions =>["store_id = ? and status = ? ",Store::DEFAULT_ID,
        Sale::STATUS[:NOMAL]]).paginate(
      :page => params[:page],:per_page => Sale::SALES_PER_PAGE_NUM,
      :order => "created_at desc")
  end
  
end
