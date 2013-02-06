#encoding: utf-8
class TeamsController < ApplicationController
  layout 'frontdoor'
  def index
    @store = Store.find(params[:store_id])
    @laster_sales = Sale.find(:all,
      :conditions => ["store_id = ? and status =?",@store.id,Sale::STATUS[:NOMAL]],
      :order=>"started_at desc", :limit => Sale::LASTER_SALES)
  end
end
