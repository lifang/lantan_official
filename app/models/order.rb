#encoding: utf-8
class Order < ActiveRecord::Base
  set_table_name :"lantan_db.orders"
  has_many :order_prod_relations
  has_many :order_pay_types
  belongs_to :car_num

  IS_BILLING = {:ONE => 1,:TWO => 2,:THREE => 3}
  
  STATUS = {:NOMAL => 0, :DELETE => 1}
  USER_INFO_PER_PAGE = 3
end
