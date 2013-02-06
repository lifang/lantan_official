#encoding: utf-8
class SvCard < ActiveRecord::Base
  has_many :svcard_prod_relations
  has_many :c_svc_relations
  CARD_TYPE ={:DISCOUNT => 0,:NOTDISCOUNT => 1}
  
end
