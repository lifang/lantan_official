class NewsController < ApplicationController #新闻控制器
  layout 'headquarter'
  def show  #新闻详情
    @current_url = request.path
    @news = New.find(params[:id])
  end
end