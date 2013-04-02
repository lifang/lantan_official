#encoding: utf-8
class PackageCard < ActiveRecord::Base
  set_table_name :"lantan_db_all.package_cards"
  has_many :pcard_prod_relations
  has_many  :c_pcard_relations
end
