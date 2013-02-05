#encoding: utf-8
class New < ActiveRecord::Base

  DEFAULT_STATUS = 0  #默认为不删除(0)

  #内容部分显示新闻条数
  NEWS_PER_PAGE_NUM = 11

end
