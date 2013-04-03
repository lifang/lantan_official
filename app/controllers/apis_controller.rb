#encoding: utf-8
class ApisController < ApplicationController  
  def get_user_svcard
    record = CSvcRelation.find_by_sql(["select csr.* from c_svc_relations csr
      left join lantan_db_all.customers c on c.id = csr.customer_id where c.mobilephone = ?",
        params[:mobilephone].strip])[0]
    status = 0
    send_message = "余额不足，您的储值卡余额为#{record.left_price}元。" if record
    if record and  record.left_price >= params[:price].to_f
      record.verify_code = proof_code(6)
      record.save
      status = 1
      send_message = "感谢您使用澜泰储值卡，您本次的消费验证码为：#{record.verify_code}。"
      message_route = "/send.do?Account=#{Constant::USERNAME}&Password=#{Constant::PASSWORD}&Mobile=#{params[:mobilephone].strip}&Content=#{send_message}&Exno=0"
      create_get_http(Constant::MESSAGE_URL, message_route)
      message = "发送成功。"
    elsif record.nil?
      message = "账号不存在。"
    end
    render :json => {:content => message, :status => status}
  end

  def use_svcard
    record = CSvcRelation.find_by_sql(["select csr.* from c_svc_relations csr
      left join lantan_db.customers c on c.id = csr.customer_id where c.mobilephone = ? and csr.verify_code = ?",
        params[:mobilephone].strip, params[:verify_code].strip])[0]
    status = 0
    message = "支付失败。"
    if record and  record.left_price >= params[:price].to_f
      left_price = record.left_price - params[:price].to_f
      SvcardUseRecord.create(:c_svc_relation_id => record.id, :types => SvcardUseRecord::TYPES[:OUT],
        :use_price => params[:price].to_f, :left_price => left_price, :content => params[:content].strip)
      record.left_price = left_price
      record.save
      status = 1
      message = "支付成功。"
    end
    render :json => {:content => message, :status => status}
  end

end
