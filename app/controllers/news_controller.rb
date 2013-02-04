class NewsController < ApplicationController #新闻控制器
  layout 'headquarter'
  def show
    @current_url = request.path
    @news = New.find(params[:id])
  end
end