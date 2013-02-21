#encoding: utf-8
#官网客户个人信息控制器
class UserInfoController < ApplicationController
  #储值卡/打折卡收支记录
  def svcard_records
    session[:current_url] = params[:cid]
    current_user = Customer.find(session[:customer_id])
    @records = current_user.c_svc_relations[0].svcard_use_records.paginate(
      :page => params[:page],:per_page => 6)  #当前用户所有储值卡记录信息
  end
  
  #消费账单
  def con_records
    @orders = Order.find(:all,
      :conditions => ["c_pcard_relation_id = ? and c_svc_relation_id = ? and status = ? ",0,0,1]).paginate(
      :page => params[:page],:per_page => 5) #消费订单记录
  end

  #按要求查找记录
  def search_records
    time = params[:int]  #判断选择情况
    is_billing = params[:is_billing]
    @records = search_records(time,is_billing)
    render "/user_info/con_records"
  end

  #套餐卡消费记录
  def pcard_records
    #获取当前用户的所有客户-套餐数据
    @c_pcard_relations = CPcardRelation.find(:all, :conditions =>["customer_id = ? and status = ?", session[:customer_id], CPcardRelation::STATUS[:NORMAL]]).paginate( :page => params[:page],:per_page => 1)
  end
  private
  
  def search_records(time,is_billing) #查找相应记录
    if is_billing == 0  #未开出
      if time == 0  #当前月
        Order.find(:all, :conditions => ["month(created_at) = month(now()) and status = ",0])
      elsif time == 1 #近二月
      elsif time == 2 #近三月
      elsif time == 3 #全部
      end
    elsif is_billing == 1 #已开出
      if time == 0  #当前月
      elsif time == 1 #近二月
      elsif time == 2 #近三月
      elsif time == 3 #全部
      end
    elsif is_billing == 2 #已寄出
      if time == 0  #当前月
      elsif time == 1 #近二月
      elsif time == 2 #近三月
      elsif time == 3 #全部
      end
    end
    Order.find(:all, :conditions => ["month(created_at) = month(now()) and status = ",0])
  end
end
