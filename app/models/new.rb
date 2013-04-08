#encoding: utf-8
class New < ActiveRecord::Base

  STATUS = {:NORMAL => 0, :UNRELEASED => 1, :DELETED => 2} #新闻状态 0正常 1未发布 2已删除
  #内容部分显示新闻条数
  NEWS_PER_PAGE_NUM = 10

end
