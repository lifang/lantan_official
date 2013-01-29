#encoding: utf-8
class CustomerNumRelation < ActiveRecord::Base
  attr_accessible :customer_id, :car_num_id
  belongs_to :customer
  belongs_to :car_num
end
