#encoding: utf-8
class CardsController < ApplicationController #储值卡
  layout "headquarter"

  #储值卡页面
  def index
    @sales_laster  = Sale.find(:all, :conditions => ["status = ? and store_id =? ",Sale::STATUS[:NOMAL],Store::DEFAULT_ID],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
  end

  #发送充值请求
  def alipay_exercise
    sv_card = SvCard.find(1)
    #支付宝中我们要用到的也写参数
    options ={
      :service=>"create_direct_pay_by_user",
      :notify_url=>Constant::SERVER_PATH+"/cards/alipay_compete",
      :subject=>"会员购买#{sv_card.name}产品",
      :total_fee=>params[:total_fee]
    }
    out_trade_no="#{session[:customer_id]}_#{Time.now.strftime("%Y%m%d%H%M%S")}#{Time.now.to_i}_#{sv_card.id}"#订单号
    #out_trade_no="#{session[:user_id]}_#{Time.now.strftime("%Y%m%d%H%M%S")}#{Time.now.to_i}_#{params[:category]}"订单号
    options.merge!(:seller_email =>Oauth2Helper::SELLER_EMAIL, :partner =>Oauth2Helper::PARTNER, :_input_charset=>"utf-8", :out_trade_no=>out_trade_no)
    options.merge!(:sign_type => "MD5", :sign =>Digest::MD5.hexdigest(options.sort.map{|k,v|"#{k}=#{v}"}.join("&")+Oauth2Helper::PARTNER_KEY))
    redirect_to "#{Oauth2Helper::PAGE_WAY}?#{options.sort.map{|k, v| "#{CGI::escape(k.to_s)}=#{CGI::escape(v.to_s)}"}.join('&')}"
  end

  #充值异步回调
  def alipay_compete
    out_trade_no=params[:out_trade_no] #订单号
    trade_nu =out_trade_no.to_s.split("_")
    order=Order.find(:first, :conditions => ["out_trade_no=?",params[:out_trade_no]])#获取订单
    if order.nil?#如果订单不存在
      alipay_notify_url = "#{Oauth2Helper::NOTIFY_URL}?partner=#{Oauth2Helper::PARTNER}&notify_id=#{params[:notify_id]}"
      response_txt =Net::HTTP.get(URI.parse(alipay_notify_url))
      my_params = Hash.new
      request.parameters.each {|key,value|my_params[key.to_s]=value}
      my_params.delete("action")
      my_params.delete("controller")
      my_params.delete("sign")
      my_params.delete("sign_type")
      mysign = Digest::MD5.hexdigest(my_params.sort.map{|k,v|"#{k}=#{v}"}.join("&")+Oauth2Helper::PARTNER_KEY)
      dir = "#{Rails.root}/public/compete"
      Dir.mkdir(dir)  unless File.directory?(dir)
      file_path = dir+"/#{Time.now.strftime("%Y%m%d")}.log"
      if File.exists? file_path
        file = File.open( file_path,"a")
      else
        file = File.new(file_path, "w")
      end
      file.puts "#{Time.now.strftime('%Y%m%d %H:%M:%S')}   #{request.parameters.to_s}\r\n"
      file.close
      if mysign==params[:sign] and response_txt=="true"
        if params[:trade_status]=="WAIT_BUYER_PAY"
          render :text=>"success"
        elsif params[:trade_status]=="TRADE_FINISHED" or params[:trade_status]=="TRADE_SUCCESS"
          @@m.synchronize {
            begin
              Order.transaction do
                order=Order.first(:conditions=>"user_id=#{trade_nu[0]} and category_id=#{trade_nu[2]} and status=#{Order::STATUS[:NOMAL]}")
                if order.nil?
                  Order.create(:user_id=>trade_nu[0],:category_id=>trade_nu[2].to_i,:pay_type=>Order::PAY_TYPES[:CHARGE],
                    :out_trade_no=>"#{params[:out_trade_no]}",:status=>Order::STATUS[:NOMAL],:remark=>"支付宝充值升级vip",
                    :start_time=>Time.now,:end_time=>Time.now+Constant::DATE_LONG.days,:types=>Order::TYPES[:CHARGE])
                end
              end
              render :text=>"success"
            rescue
              render :text=>"success"
            end
          }
        else
          render :text=>"fail" + "<br>"
        end
      else
        redirect_to "/"
      end
    else
      render :text=>"success"
    end
  end
  
end
