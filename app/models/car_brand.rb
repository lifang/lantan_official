#encoding: utf-8
class CarBrand < ActiveRecord::Base
 belongs_to :capital
 has_many :car_models
end
