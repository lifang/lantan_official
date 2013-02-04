#encoding: utf-8
class Sale < ActiveRecord::Base
  has_many :sale_prod_relations
  belongs_to :store
  #0 正常状态  1 删除装填
  STATUS = {:NOMAL => 0, :DELETED => 1}  
  #最新活动条数
  LASTER_SALES = 2
  #左侧活动列表显示条数
   NEW_NUM = 6
  #内容部分显示活动条数
  SALES_PER_PAGE_NUM = 3
end
