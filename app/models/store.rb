#encoding: utf-8
class Store < ActiveRecord::Base
  STATUS = {
    :CLOSED => 0,       #0该门店已关闭，1正常营业，2装修中, 3已删除
    :OPENED => 1,
    :DECORATED => 2,
    :DELETED => 3
  }
end
