#encoding: utf-8
class OrderPayType < ActiveRecord::Base
  set_table_name :"lantan_db.order_pay_types"
  set_primary_key "id"
 belongs_to :order
 TYPES = {:one => "现金", :two => "银行卡"}
end
