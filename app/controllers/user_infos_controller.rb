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
    @time = "0"
    @is_billing = "0"
    @orders = search_records(@time,@is_billing)
  end

  def search
    session[:time] = params[:time] if params[:time]
    session[:is_billing] = params[:is_billing] if params[:is_billing]
    @time = params[:time] || session[:time]
    @is_billing = params[:is_billing] || session[:is_billing]
    @orders = search_records(@time,@is_billing)
    render :con_records

  end

  #套餐卡消费记录
  def pcard_records
    #获取当前用户的所有客户-套餐数据
    @c_pcard_relations = CPcardRelation.find(:all, :conditions =>["customer_id = ? and status = ?", session[:customer_id], CPcardRelation::STATUS[:NORMAL]]).paginate( :page => params[:page],:per_page => 1)
  end
  private
  
  def search_records(time,is_billing) #查找相应记录
    time = time.to_i
    case time
    when 0, 1, 2
      @orders = Order.find(:all,
        :conditions => [" subdate(now(),interval #{time+1} month) < created_at and status = ?
and is_billing = ? ",
          Order::STATUS[:NOMAL],is_billing], :order => "created_at desc").paginate(
        :page => params[:page],
        :per_page =>1)
    else
      @orders = Order.find(:all,
        :conditions => [" status = ? and is_billing = ?",Order::STATUS[:NOMAL],is_billing], :order => "created_at desc").paginate(
        :page => params[:page],
        :per_page =>1)
    end
    return @orders
  end
end
