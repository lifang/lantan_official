class CarNum < ActiveRecord::Base
  attr_accessible :num, :car_model_id
  belongs_to :car_model
  has_one :customer_num_relation
  has_many :orders
  
end
