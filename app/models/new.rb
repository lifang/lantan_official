#encoding: utf-8
class New < ActiveRecord::Base

  STATUS = {:NOMAL => 0, :DELETED => 1} #0 正常  #1 删除
  #内容部分显示新闻条数
  NEWS_PER_PAGE_NUM = 10

end
