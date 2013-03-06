#encoding: utf-8
class SvcardUseRecord < ActiveRecord::Base
  belongs_to :c_svc_relation
  SVCARD_TYPE = {:TYPR_ONR => 0, :TYPE_TWO => 1} #type_one =>  储值卡，type_two =>  打折卡
  
end
