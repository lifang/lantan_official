#encoding: utf-8
class Product < ActiveRecord::Base
  has_many :sale_prod_relations
  has_many :res_prod_relations
  has_many :station_service_relations
  has_many :prod_mat_relations
  has_many :pcard_prod_relations
  has_many :svcard_prod_relations

  IS_SERVICE = {:YES => 1, :NO => 0} #是否服务  1 是  0 否
end
