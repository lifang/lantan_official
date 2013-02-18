#encoding: utf-8
#官网客户个人信息控制器
class UserInfoController < ApplicationController
  #储值卡/打折卡收支记录
  def svcard_records
    current_user = Customer.find(session[:customer_id])
    
    @records = current_user.c_svc_relations[0].svcard_use_records  #储值卡记录信息
    
    #types => 1 为  储值卡
    
    #types => 2 为  打折卡
    
  end
  
  #消费账单
  def con_records
    @all = Order.find(:all,
      :conditions => ["c_pcard_relation_id = ? and c_svc_relation_id = ? and status = ? ",0,0,1]) #消费订单记录
    
    
    
    
    
     
  end
end
