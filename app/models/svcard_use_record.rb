#encoding: utf-8
class SvcardUseRecord < ActiveRecord::Base
  attr_accessible :c_svc_relation_id, :types, :use_price, :left_price, :content
  belongs_to :c_svc_relation
  TYPES = {:IN => 0, :OUT => 1}  #0 充值， 1 消费
end
