#encoding: utf-8
class Customer < ActiveRecord::Base
  set_table_name :"lantan_db.customers"
  set_primary_key "id"
  attr_accessible :name, :mobilephone, :address, :status, :types
  has_many :customer_num_relations
  has_many :c_svc_relations
  has_many :c_pcard_relations

  STATUS = {:NOMAL => 0, :DELETED => 1} #0 正常  1 删除
  TYPES = {:GOOD => 0, :NORMAL => 1, :STRESS => 2} #1 优质客户  2 一般客户  3 重点客户

end
