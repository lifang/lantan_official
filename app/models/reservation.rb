#encoding: utf-8
class Reservation < ActiveRecord::Base
  attr_accessible :car_num_id, :res_time, :store_id, :status
  belongs_to :store
  has_many :res_prod_relations
  DEFAULT_STATUS = 1
end
