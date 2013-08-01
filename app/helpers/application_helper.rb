module ApplicationHelper
  require 'net/http'
  require "uri"
  require 'openssl'
  
  include Constant
  #最新活动
  def sales_laster
    Sale.find(:all, :conditions => ["status = ?",Sale::STATUS[:RELEASE]],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
  end

  #门店中的最新活动
  def store_lasted_sales
    store_id = params[:store_id].nil? ? params[:id].to_i : params[:store_id].to_i
    SSale.find(:all,
      :conditions => ["store_id = ? and status = ? ", store_id,
        SSale::STATUS[:RELEASE]], :order=>"created_at desc", :limit => SSale::LASTER_SALES)
  end

  def sign?
    deny_access unless signed_in?
  end

  def deny_access
    redirect_to "/login?last_url=#{request.url}"
  end

  def signed_in?
    return session[:customer_id] != nil
  end

  def proof_code(len)
    chars = ('A'..'Z').to_a + ('a'..'z').to_a + (0..9).to_a
    code_array = []
    1.upto(len) {code_array << chars[rand(chars.length)]}
    return code_array.join("")
  end

  def create_get_http(url,route)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    if uri.port==443
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    request= Net::HTTP::Get.new(route)
    back_res =http.request(request)
    return JSON back_res.body
  end
  
end