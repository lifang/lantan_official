class NewsController < ApplicationController #新闻控制器
  layout 'headquarter'

  #新闻中心首页
  def index
     @sales_laster = Sale.find(:all, :conditions => ["status = ? and store_id = ?",Sale::STATUS[:NOMAL],Store::DEFAULT_ID],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
    @news = New.find(:all ,:conditions => ["status = ? ",New::DEFAULT_STATUS]).paginate(
      :page => params[:page],:per_page => New::NEWS_PER_PAGE_NUM,:order => "created_at desc")
  end
  #新闻详细
  def show
    @sales_laster = Sale.find(:all, :conditions => ["status = ? and store_id = ?",Sale::STATUS[:NOMAL],Store::DEFAULT_ID],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
    @new = New.find(params[:id])
  end
end