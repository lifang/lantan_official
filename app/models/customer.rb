#encoding: utf-8
class Customer < ActiveRecord::Base
  attr_accessible  :name, :mobilephone, :address
  has_many :customer_num_relations
  has_many :c_svc_relations
  has_many :c_pcard_relations
  DEFAULT_TYPES = 1
end
