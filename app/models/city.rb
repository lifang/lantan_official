#encoding: utf-8
class City < ActiveRecord::Base
  attr_accessible  :name, :parent_id
end
