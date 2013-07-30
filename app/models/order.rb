#encoding: utf-8
class Order < ActiveRecord::Base
  set_table_name :"lantan_db.orders"
  set_primary_key "id"
  has_many :order_prod_relations
  has_many :s_products, :through => :order_prod_relations, :foreign_key => 'product_id'
  has_many :order_pay_types
  belongs_to :car_num
  belongs_to :s_store, :foreign_key => 'store_id'

  IS_BILLING = {:ONE => 1,:TWO => 2,:THREE => 3}
  STATUS = {:NORMAL => 0, :SERVICING => 1, :WAIT_PAYMENT => 2, :BEEN_PAYMENT => 3, :FINISHED => 4, :DELETED => 5, :INNORMAL => 6}
  #0 正常未进行  1 服务中  2 等待付款  3 已经付款  4 已结束  5已删除  6未分配工位
 
  USER_INFO_PER_PAGE = 3

  def billing_status
    is_billing ? "已开" : "未开"
  end
end
