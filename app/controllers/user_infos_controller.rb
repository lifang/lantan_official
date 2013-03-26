#encoding: utf-8
#官网客户个人信息控制器
class UserInfosController < ApplicationController
  include  ApplicationHelper
  before_filter :sign?
  layout "user_infos"

  #储值卡/打折卡收支记录
  def svcard_records
    @svcard_records = SvcardUseRecord.paginate_by_sql(["select sur.* from svcard_use_records sur
      inner join c_svc_relations csr on csr.id = sur.c_svc_relation_id where csr.customer_id = ? 
      order by sur.created_at desc", session[:customer_id]], :page => params[:page],
      :per_page => CSvcRelation::PER_PAGE)
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
    @time = time
    @is_billing = is_billing
    render "/user_info/con_records"
  end

  #套餐卡消费记录
  def pcard_records
    #获取当前用户的所有客户-套餐数据
    @c_pcard_relations = CPcardRelation.find(:all, :conditions =>["customer_id = ? and status = ?", session[:customer_id], CPcardRelation::STATUS[:NORMAL]]).paginate( :page => params[:page],:per_page => 1)
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
