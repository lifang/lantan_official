#encoding: utf-8
class SvCard < ActiveRecord::Base
  has_many :svcard_prod_relations
  has_many :c_svc_relations
  CARD_TYPE ={:DISCOUNT => 0,:NOTDISCOUNT => 1} # 0 打折卡 1 储值卡
  STATUS = {:NORMAL => 1, :DELETED => 0} #状态 1正常 0删除
end
