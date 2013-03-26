#encoding: utf-8
class OrderProdRelation < ActiveRecord::Base
  set_table_name :"lantan_db.order_prod_relations"
  belongs_to :order
end
