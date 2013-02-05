class NewsController < ApplicationController #新闻控制器
  layout 'headquarter'
  def index
     @sales_laster = Sale.find(:all, :conditions => ["status = ? and store_id = ?",Sale::STATUS[:NOMAL],Store::DEFAULT_ID],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
    @news = New.find(:all ,:conditions => ["status = ? ",Sale::STATUS[:NOMAL]]).paginate(
      :page => params[:page],:per_page => New::NEWS_PER_PAGE_NUM,:order => "created_at desc")
    @current_url = request.path
  end

  def show
    @sales_laster = Sale.find(:all, :conditions => ["status = ? and store_id = ?",Sale::STATUS[:NOMAL],Store::DEFAULT_ID],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
    @new = New.find(params[:id])
  end
 
end