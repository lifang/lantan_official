#encoding: utf-8
class OrderPayType < ActiveRecord::Base
 belongs_to :order
 TYPES = {:one => "现金", :two => "银行卡"}
end
