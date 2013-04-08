#encoding: utf-8
class Sale < ActiveRecord::Base
  has_many :sale_prod_relations
  belongs_to :store
  #最新活动条数
  LASTER_SALES = 2
  #左侧活动列表显示条数
   NEW_NUM = 6
  #内容部分显示活动条数
  SALES_PER_PAGE_NUM = 3

  STATUS ={:UN_RELEASE => 0,:RELEASE => 1,:DESTROY => 2} #0 未发布 1 发布 2 删除
  STATUS_NAME = {0 => "未发布", 1 => "已发布"}
  DISC_TYPES = {:FEE => 1,:DIS => 0} #1 优惠金额  0 优惠折扣
  DISC_TYPES_NAME = {1 => "金额优惠", 0 => "折扣"}
  DISC_TIME = {:DAY => 1, :MONTH => 2, :YEAR => 3, :WEEK => 4, :TIME => 0} #1 每日 2 每月 3 每年 4 每周 0 时间段
  DISC_TIME_NAME = {1 => "本年度每天", 2 => "本年度每月", 3 => "本年度每年", 4 => "本年度每周", 0 => "时间段" }
end