#encoding: utf-8
class CarNum < ActiveRecord::Base
  set_table_name :"lantan_db_all.car_nums"
  set_primary_key "id"
  attr_accessible :num
  belongs_to :car_model
  has_one :customer_num_relation
  has_many :orders
  
end
