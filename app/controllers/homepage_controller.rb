#encoding: utf-8
class HomepageController < ApplicationController  #总部控制器
  layout 'headquarter', :except => [:index, :login, :regist, :regist_create]
  def index 
    @news = New.find(:all, :conditions => "status = '#{New::STATUS[:NOMAL]}'",
      :order => "created_at desc", :limit => 6)
    @services = Product.find(:all, :select => "id, name, types", :conditions => ["is_service = ?",
        Product::IS_SERVICE[:YES]]).group_by { |s| s.types }

  end

  def regist_create 
    if Customer.find_by_name_and_mobilephone(params[:name].strip, params[:mobilephone].strip).nil?
      Customer.transaction do 
        customer = Customer.create(:name => params[:name].strip,:mobilephone =>  params[:mobilephone].strip,
          :address => params[:address].strip, :status => Customer::STATUS[:NOMAL], :types => Customer::TYPES[:NORMAL])
        car_num = CarNum.create(:num => params[:car_num].strip)
        CustomerNumRelation.create(:customer_id => customer.id, :car_num_id => car_num.id)
        session[:customer_id] = customer.id
      end
    else
      flash[:notice] = "您已经是注册的会员，账号和密码是您首次注册的姓名和手机号码。"
      redirect_to "/regist"
    end
  end
  
  def login_create
    customer = Customer.find_by_name_and_mobilephone(params[:name].strip, params[:mobilephone].strip)
    if customer.nil?
      flash[:notice] = "用户名或密码错误，请重新登录。"
      redirect_to "/login"
    else
      session[:customer_id] = customer.id
      redirect_to params[:last_url].nil?  ? "/homepage" : params[:last_url]
    end
  end
  
  def logout
    session[:customer_id] = nil
    redirect_to root_path
  end
 
  def contact_us
    @store = Store.first
  end
 
end
