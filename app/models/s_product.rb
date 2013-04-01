#encoding: utf-8
class SProduct < ActiveRecord::Base
  set_table_name :"lantan_db.products"

  IS_SERVICE = {:YES => 1, :NO => 0} #是否为产品或者服务，1服务，0产品
  IS_SERVICE_VALUE = {:YES => true, :NO => false}
  PRODUCT_TYPES = {0 => "汽车清洁用品", 1 => "汽车美容用品", 2 => "汽车装饰产品", 3 => "汽车配件产品",
    4 => "汽车电子产品", 11 => "其它产品"} #产品类别
  SERVICE_TYPES = {5 => "清洗服务", 6 => "维修服务", 7 => "钣喷服务", 8 => "美容服务", 9 => "安装服务", 10 => "其它服务"} #服务类别

  STATUS = {:NOMAL => 0, :DELETED => 1} #0 正常  1 删除
end
