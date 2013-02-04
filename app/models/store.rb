#encoding: utf-8
class Store < ActiveRecord::Base
  has_many :stations
  has_many :reservations
  has_many :products
  has_many :sales
  has_many :work_orders
  has_many :svc_return_records
  has_many :package_cards
  DEFAULT_ID = 1    #默认为总店id(1)
end
