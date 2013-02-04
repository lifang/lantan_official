#encoding: utf-8
class Sale < ActiveRecord::Base
  has_many :sale_prod_relations
  belongs_to :store

  STATUS = {:NOMAL => 0, :DELETED => 1}  #0 正常状态  1 删除装填
    #
  #my own configration
  #

  # => status 0:true 1:false
  STATUS_TRUE = 0
  STATUS_FALSE = 1

  # => product types 0  => service/1 => product
  PRODUCT_SERVICE = 0
  PRODUCT_PRODUCT = 1

  # => the num of laster sales per_page
  LASTRT_SALES = 2

  # => the num of news list => limit => num
  NEW_NUM = 6
  # => the num of laster news per_page
  NEWS_PER_PAGE_NUM = 3
  # => the num of laster sales per_page
  SALES_PER_PAGE_NUM = 3
end
