#encoding: utf-8
class ResProdRelation < ActiveRecord::Base
  attr_accessible :product_id, :reservation_id
  belongs_to :product
  belongs_to :reservation
end
