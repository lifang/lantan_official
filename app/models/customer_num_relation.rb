#encoding: utf-8
class CustomerNumRelation < ActiveRecord::Base
  set_table_name :"lantan_db.customer_num_relations"
  set_primary_key "id"
  attr_accessible :car_num_id, :customer_id
  belongs_to :customer
  belongs_to :car_num
end
