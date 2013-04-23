#encoding: utf-8
class Product < ActiveRecord::Base
  has_many :sale_prod_relations
  has_many :res_prod_relations
  has_many :station_service_relations
  has_many :prod_mat_relations
  has_many :pcard_prod_relations
  has_many :svcard_prod_relations
  has_many :image_urls


  IS_SERVICE = {:YES => 1, :NO => 0} #是否为产品或者服务，1服务，0产品
  PRODUCT_TYPES = {0 => "汽车清洁用品", 1 => "汽车美容用品", 2 => "汽车装饰产品", 3 => "汽车配件产品", 
    4 => "汽车电子产品", 5 => "其它产品"} #产品类别
  SERVICE_TYPES = {6 => "清洗服务", 7 => "维修服务", 8 => "钣喷服务", 9 => "美容服务", 10 => "安装服务", 11 => "其它服务"} #服务类别

  STATUS = {:NOMAL => 1, :DELETED => 0} #1 正常  0 删除

end
