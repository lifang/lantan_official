#encoding: utf-8
class CardsController < ApplicationController #储值卡
  layout "headquarter"
  before_filter :sign?, :only => ["check_card","alipay_exercise"]
  @@m = Mutex.new
 
  #储值卡页面
  def index
    sv_cards = SvCard.all
    @sv_cards = sv_cards.group_by{ |c| c.types }
  end

  #发送充值请求
  def alipay_exercise
    sv_card = SvCard.find(params[:sv_card].to_i)  #购买的储值卡
    #支付宝中我们要用到的也写参数
    options ={
      :service=>"create_direct_pay_by_user",
      :notify_url=>Constant::OFFICIAL_PATH+"/cards/alipay_compete",  #请求地址
      :subject=>"会员购买#{sv_card.name}产品", #物品名称
      :total_fee =>params[:total_fee] #订单总金额
    }
    out_trade_no="#{session[:customer_id]}_#{Time.now.strftime("%Y%m%d%H%M%S")}#{Time.now.to_i}_#{params[:sv_card]}_#{params[:fee_type]}"#订单号
    options.merge!(:seller_email => Constant::SELLER_EMAIL, :partner => Constant::PARTNER,
      :_input_charset=>"utf-8", :out_trade_no=>out_trade_no,:payment_type => 1)
    options.merge!(:sign_type => "MD5", :sign =>Digest::MD5.hexdigest(options.sort.map{|k,v|"#{k}=#{v}"}.join("&")+Constant::PARTNER_KEY))
    redirect_to "#{Constant::PAGE_WAY}?#{options.sort.map{|k, v| "#{CGI::escape(k.to_s)}=#{CGI::escape(v.to_s)}"}.join('&')}"
  end

  def check_card
    c_svc = CSvcRelation.find_by_sql("select * from c_svc_relations r inner join sv_cards s on s.id=r.sv_card_id where s.types=#{SvCard::CARD_TYPE[:NOTDISCOUNT]}
      and r.customer_id=#{params[:user_id]} and r.sv_card_id=#{params[:card_id]}")[0]
    respond_to do |format|
      format.json {
        render :json=>{:card_id=>params[:card_id],:total_fee=>params[:total_fee],:fee_type=>params[:fee_type],:checked=>c_svc.nil?}
      }
    end
  end


  #充值异步回调
  def alipay_compete
    out_trade_no =params[:out_trade_no] #订单号
    trade_nu =out_trade_no.to_s.split("_")
    alipay_notify_url = "#{Constant::NOTIFY_URL}?partner=#{Constant::PARTNER}&notify_id=#{params[:notify_id]}"
    response_txt =Net::HTTP.get(URI.parse(alipay_notify_url))
    my_params = Hash.new
    request.parameters.each {|key,value|my_params[key.to_s]=value}
    my_params.delete("action")
    my_params.delete("controller")
    my_params.delete("sign")
    my_params.delete("sign_type")
    mysign = Digest::MD5.hexdigest(my_params.sort.map{|k,v|"#{k}=#{v}"}.join("&")+ Constant::PARTNER_KEY)
    dir = "#{Rails.root}/public/logs"
    Dir.mkdir(dir)  unless File.directory?(dir)
    file = File.open(dir+"/#{Time.now.strftime("%Y%m")}.log","a+")
    file.write "#{Time.now.strftime('%Y%m%d %H:%M:%S')}   #{request.parameters.to_s}\r\n"
    if mysign==params[:sign] and response_txt=="true"
      if params[:trade_status]=="WAIT_BUYER_PAY"
        render :text=>"success"
      elsif params[:trade_status]=="TRADE_FINISHED" or params[:trade_status]=="TRADE_SUCCESS"
        @@m.synchronize {
          begin
            spr =SvcardProdRelation.find_by_sv_card_id(trade_nu[2].to_i)
            sv_card = SvCard.find_by_id trade_nu[2].to_i
            CSvcRelation.transaction do
              pars = {:customer_id=>trade_nu[0].to_i,:sv_card_id=>trade_nu[2].to_i,:created_at=>Time.now}
              if trade_nu[3].to_i == SvCard::CARD_TYPE[:NOTDISCOUNT]
                total_price = spr.try(:base_price).to_f+spr.try(:more_price).to_f
                c_sv_relation = CSvcRelation.create!( pars.merge!(:total_price =>total_price, :left_price =>total_price, :status => CSvcRelation::STATUS[:valid]))
                SvcardUseRecord.create(:c_svc_relation_id =>c_sv_relation.id,:types=>SvcardUseRecord::TYPES[:IN],:use_price=>total_price,
                    :left_price=>total_price,:content=>"购买#{sv_card.name}")
              else
                CSvcRelation.create(pars.merge(:total_price=>params[:total_fee], :status => CSvcRelation::STATUS[:valid]))
              end
               customer = Customer.find(trade_nu[0].to_i)
               customer.update_attributes(:is_vip=>Customer::IS_VIP[:VIP])
            end
            render :text=>"success"
          rescue
            file.write "save data failed\r\n"
            render :text=>"success"
          end
        }
      else
        render :text=>"fail" + "<br>"
      end
    else
      redirect_to "/"
    end
    file.close
  end
end
