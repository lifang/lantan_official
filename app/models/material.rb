#encoding: utf-8
class Material < ActiveRecord::Base
  has_many :prod_mat_relations
end
