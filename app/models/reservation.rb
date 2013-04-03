#encoding: utf-8
class Reservation < ActiveRecord::Base
  set_table_name :"lantan_db_all.reservations"
  set_primary_key "id"
  attr_accessible :car_num_id, :res_time, :store_id, :status
  belongs_to :s_store
  has_many :res_prod_relations

  STATUS = {:NOMAL => 0, :CANCEL => 1} #0 正常  1 无效
end
