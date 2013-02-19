#encoding: utf-8
class CPcardRelation < ActiveRecord::Base
  belongs_to :package_card
  belongs_to :customer
  STATUS = {:NORMAL => 1, :DELETED => 0} #NORMAL显示，DELETED删除(不显示)
end
