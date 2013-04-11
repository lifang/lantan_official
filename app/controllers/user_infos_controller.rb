#encoding: utf-8
class UserInfosController < ApplicationController

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
    @c_pcard_relations = CPcardRelation.find_by_sql(["select p.id, p.name, cpr.content, cpr.ended_at
        from lantan_db_all.c_pcard_relations cpr
        inner join lantan_db_all.package_cards p on p.id = cpr.package_card_id
        where cpr.status = ? and cpr.customer_id = ?",
        CPcardRelation::STATUS[:NORMAL], session[:customer_id]])
    @already_used_count = {}
    unless @c_pcard_relations.blank?
      @c_pcard_relations.each do |r|
        service_infos = r.content.split(",")
        single_car_content = {}
        service_infos.each do |s|
          content_arr = s.split("-")
          single_car_content[content_arr[0].to_i] = [content_arr[1], content_arr[2].to_i] if content_arr.length == 3
        end
        @already_used_count[r.id] = single_car_content unless single_car_content.empty?
      end
      @pcard_prod_relations = PcardProdRelation.find(:all, :conditions => ["package_card_id in (?)", @c_pcard_relations])
      @pcard_prod_relations.each do |ppr|
        used_count = ppr.product_num - @already_used_count[ppr.package_card_id][ppr.product_id][1] if !@already_used_count.empty? and @already_used_count[ppr.package_card_id][ppr.product_id]
        @already_used_count[ppr.package_card_id][ppr.product_id][1] = used_count ? used_count : 0 unless @already_used_count.empty?
      end
    end
  end

  
  private
  
  def search_records(time,is_billing) #查找相应记录
    time = time.to_i
    case time

    when 0, 1, 2
      @orders = Order.find(:all,
        :joins => [:s_store, :order_pay_types],
        :conditions => [" subdate(now(),interval #{time+1} month) < orders.created_at and orders.status = ?
and is_billing = ? and customer_id = ?", Order::STATUS[:FINISHED],is_billing, session[:customer_id]],
        :order => "orders.created_at desc").paginate(
        :page => params[:page],
        :per_page =>Order::USER_INFO_PER_PAGE)
    else
      @orders = Order.find(:all,
        :joins => [:s_store, :order_pay_types],
        :conditions => [" orders.status = ? and is_billing = ? and customer_id = ?",Order::STATUS[:FINISHED],is_billing,session[:customer_id]],:order => "orders.created_at desc").paginate(
        :page => params[:page],
        :per_page =>Order::USER_INFO_PER_PAGE)
    end
    return @orders
  end

  
end
