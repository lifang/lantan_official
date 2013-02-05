#encoding: utf-8
class CardsController < ApplicationController #储值卡
  layout "headquarter"
  
  def index
    @sales_laster  = Sale.find(:all, :conditions => ["status = ?",Sale::STATUS[:NOMAL]],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
  end
  
  private

  def show_sales
    Sale.find(:all, :conditions =>["store_id = 1 and status = ? ",
        Sale::STATUS[:NOMAL]]).paginate(
      :page => params[:page],:per_page => Sale::SALES_PER_PAGE_NUM,
      :order => "created_at desc")
  end
end
