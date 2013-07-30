#encoding: utf-8
class ResProdRelation < ActiveRecord::Base
  set_table_name :"lantan_db.res_prod_relations"
  set_primary_key "id"
  attr_accessible :product_id, :reservation_id
  belongs_to :product
  belongs_to :reservation
end
