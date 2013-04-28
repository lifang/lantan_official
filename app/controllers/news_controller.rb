class NewsController < ApplicationController #新闻控制器
  layout 'headquarter'

  #新闻中心首页
  def index
    @news = New.find(:all ,:conditions => ["status = ? ",New::STATUS[:NORMAL]]).paginate(
      :page => params[:page],:per_page => New::NEWS_PER_PAGE_NUM,:order => "created_at desc")
  end
  
  #新闻详细
  def show
      @new = New.find_by_id(params[:id].to_i)
  end
end