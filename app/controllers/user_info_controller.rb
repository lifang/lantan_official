#encoding: utf-8
#官网客户个人信息控制器
class UserInfoController < ApplicationController
  #储值卡收支记录
  def svcard_records
    
  end
  
  #消费账单
  def con_records
    
  end

  #套餐卡消费记录
  def pcard_records
    c_pcard_relations = CPcardRelation.find(:all, :conditions =>["customer_id = ? and status = ?", session[:customer_id], CPcardRelation::STATUS[:NORMAL]])
    if !c_pcard_relations.blank?
      package_card_array = []
      c_pcard_relations.each do |c_pcard_relation|
        package_card_array << PackageCard.find(c_pcard_relation.package_card_id)
        
      end
    end
  end
end
