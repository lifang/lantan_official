#encoding: utf-8
#官网客户个人信息控制器
class UserInfoController < ApplicationController
  include  ApplicationHelper
  #储值卡/打折卡收支记录
  def svcard_records
    if session[:customer].nil?
      redirect_to "/homepage/login"
    else
      @order = Order.find(:all, :conditions =>["c_svc_relation_id = ? and status = ?",
          CSvcRelation.find(current_user.id),Order::STATUS[:NOMAL]],
        :order => "created_at desc").paginate(:page => params[:page],
        :per_page => CSvcRelation::PER_PAGE)
    end
  end
  #消费账单
  def con_records
    search_records("4","0")
  end

  #按要求查找记录
  def search
    time = params[:time]  #判断选择情况
    is_billing = params[:is_billing]
    @orders = search_records(time,is_billing)
    render "/user_info/con_records"
  end
  
  private
  def search_records(time,is_billing) #查找相应记录
    if time == "0"  #当前月
      @orders = Order.find(:all,
        :conditions => [" subdate(now(),interval 1 month) < created_at and status = ?
and is_billing = ? and c_svc_relation_id = 0 and c_pcard_relation_id = 0",
          Order::STATUS[:NOMAL],is_billing], :order => "created_at desc").paginate(
        :page => params[:page],
        :per_page =>Order::USER_INFO_PER_PAGE)
    elsif time == "1" #近二月
      @orders = Order.find(:all,
        :conditions => ["subdate(now(),interval 2 month) < created_at and status = ?
 and is_billing = ? and c_svc_relation_id = 0 and c_pcard_relation_id = 0",
          Order::STATUS[:NOMAL],is_billing], :order => "created_at desc").paginate(
        :page => params[:page],
        :per_page =>Order::USER_INFO_PER_PAGE)
    elsif time == "2" #近三月
      @orders = Order.find(:all,
        :conditions => ["subdate(now(),interval 3 month) < created_at and status = ?
 and is_billing = ? and c_svc_relation_id = 0 and c_pcard_relation_id = 0",
          Order::STATUS[:NOMAL],is_billing], :order => "created_at desc").paginate(
        :page => params[:page],
        :per_page =>Order::USER_INFO_PER_PAGE)
    elsif time == "3" #全部
      @orders = Order.find(:all,
        :conditions => [" status = ? and is_billing = ?  and c_svc_relation_id = 0
and c_pcard_relation_id = 0",Order::STATUS[:NOMAL],is_billing], :order => "created_at desc").paginate(
        :page => params[:page],
        :per_page =>Order::USER_INFO_PER_PAGE)
    else
      @orders = Order.find(:all,
        :conditions => [" subdate(now(),interval 1 month) < created_at and status = ?
and is_billing = ? and c_svc_relation_id = 0 and c_pcard_relation_id = 0",
          Order::STATUS[:NOMAL],is_billing], :order => "created_at desc").paginate(
        :page => params[:page],
        :per_page =>Order::USER_INFO_PER_PAGE)
    end
    return @orders
  end
end
