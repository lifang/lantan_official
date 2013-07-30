#encoding: utf-8
class OrderPayType < ActiveRecord::Base
  set_table_name :"lantan_db.order_pay_types"
  set_primary_key "id"
  belongs_to :order
  PAY_TYPES_NAME = {0 => "现金", 1 => "刷卡", 2 => "优惠卡", 3 => "套餐卡", 4 => "活动优惠"}
end
