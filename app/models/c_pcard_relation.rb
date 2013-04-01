#encoding: utf-8
class CPcardRelation < ActiveRecord::Base
  set_table_name :"lantan_db.c_pcard_relations"
  belongs_to :package_card
  belongs_to :customer

  STATUS = {:NORMAL => 1, :DELETED => 0} #NORMAL显示，DELETED删除(不显示)
  
end
