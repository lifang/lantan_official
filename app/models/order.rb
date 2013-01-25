#encoding: utf-8
class Order < ActiveRecord::Base
 has_many :order_prod_relations
 has_many :order_pay_types
 belongs_to :car_num
end
