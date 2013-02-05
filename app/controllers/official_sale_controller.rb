#encoding: utf-8
class OfficialSaleController < ApplicationController  #总店活动促销页面
  layout "headquarter", :except => [:login]
   
  def index
    @sales_laster = Sale.find(:all, :conditions => ["status = ?",Sale::STATUS[:NOMAL]],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
    @sales=show_sales
    @current_url = request.path
  end

  def show
    @sales_laster = Sale.find(:all, :conditions => ["status = ?",Sale::STATUS[:NOMAL]],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
    sale_id=params[:id]
    @sale = Sale.find(sale_id)
  end

  def province_change
    options = "<option value='0'>--请选择--</option>"
    city = City.where("parent_id = ?",params[:id]).all
    city.each do |c|
      options << "<option value=#{c.id}>#{c.name}</option>"
    end
    render :text => options
  end
  
  def city_change
    items = ""
    stores = Store.where("city_id = ?",params[:id]).all
    stores.each do |s|
      items << "<a href = '/stores/#{s.id}'><li value=#{s.id}>#{s.name}</li></a>"
    end
    render :text => items
  end
  
  #在线预约
  def city_change_reservations
    items = ""
    stores = Store.where("city_id = ?",params[:id]).all
    stores.each do |s|
      items << "<a href = '/stores/#{s.id}/reservations/new'><li value=#{s.id}>#{s.name}</li></a>"
    end
    render :text => items
  end
  
  def province_change_reservations
    options = "<option value='0'>--请选择--</option>"
    city = City.where("parent_id = ?",params[:id]).all
    city.each do |c|
      options << "<option value=#{c.id}>#{c.name}</option>"
    end
    render :text => options
  end
  
  private

  def show_sales
    Sale.find(:all, :conditions =>["store_id = 1 and status = ? ",
        Sale::STATUS[:NOMAL]]).paginate(
      :page => params[:page],:per_page => Sale::SALES_PER_PAGE_NUM,
      :order => "created_at desc")
  end
  
end
