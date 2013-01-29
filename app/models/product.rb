#encoding: utf-8
class Product < ActiveRecord::Base
  has_many :sale_prod_relations
  has_many :res_prod_relations
  has_many :station_service_relations
  has_many :prod_mat_relations
  has_many :pcard_prod_relations
  has_many :svcard_prod_relations

  IS_SERVICE = {:YES => 1, :NO => 0} #是否服务  1 是  0 否
  PRODUCT_TYPES = {0 => "汽车清洁用品", 1 => "汽车美容用品", 2 => "汽车装饰产品", 3 => "汽车配件产品", 4 => "汽车电子产品"} #产品类别
  SERVICE_TYPES = {5 => "清洗服务", 6 => "维修服务", 7 => "钣喷服务", 8 => "美容服务", 9 => "安装服务"} #服务类别

end
