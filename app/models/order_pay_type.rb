#encoding: utf-8
class OrderPayType < ActiveRecord::Base
  set_table_name :"lantan_db_all.order_pay_types"
 belongs_to :order

end
