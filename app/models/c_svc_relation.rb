#encoding: utf-8
class CSvcRelation < ActiveRecord::Base
  has_many :svcard_use_records
  belongs_to :sv_card
  belongs_to :customer

  #储值卡显示条数
  PER_PAGE = 10
end
