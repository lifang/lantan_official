#encoding: utf-8
class CardsController < ApplicationController #储值卡
  layout "headquarter"

  #储值卡页面
  def index
    @sales_laster  = Sale.find(:all, :conditions => ["status = ? and store_id =? ",Sale::STATUS[:NOMAL],Store::DEFAULT_ID],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
  end
  
end
