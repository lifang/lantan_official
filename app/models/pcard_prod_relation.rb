#encoding: utf-8
class PcardProdRelation < ActiveRecord::Base
  set_table_name :"lantan_db.pcard_prod_relations"
  belongs_to :package_card
  belongs_to :product
end
