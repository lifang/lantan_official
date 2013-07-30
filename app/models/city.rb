#encoding: utf-8
class City < ActiveRecord::Base
  set_table_name :"lantan_db.cities"
  set_primary_key "id"
  attr_accessible  :name, :parent_id
end
