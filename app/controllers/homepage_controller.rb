#encoding: utf-8
class HomepageController < ApplicationController  #总部控制器
  layout 'headquarter', :except => [:index, :login, :regist, :regist_create]
  def index 
    @news = New.find(:all, :conditions => "status = '#{New::DEFAULT_STATUS}'",
      :order => "created_at desc", :limit => 6)
    services = Product.find(:all, :select => "id, name, types", :conditions => ["is_service = ?",
        Product::IS_SERVICE[:YES]])
    @service_hash = {}
    Product::SERVICE_TYPES.each_key do |key|
      services.each do |service|
        if(service.types == key)
          if @service_hash[key].nil?
            @service_hash[key] = []
            @service_hash[key] << service
          else
            @service_hash[key] << service
          end
        end
      end
    end
  end

  def regist_create 
    if Customer.find_by_name_and_mobilephone(params[:name].strip, params[:mobilephone].strip).nil?
      customer = Customer.new(:name => params[:name].strip,:mobilephone =>  params[:mobilephone].strip,
        :address => params[:address].strip)
      if customer.save
        car_num = CarNum.create(:num => params[:car_num].strip)
        CustomerNumRelation.create(:customer_id => customer.id, :car_num_id => car_num.id)
        session[:customer_id] = customer.id
      end
    else
      redirect_to "/homepage/regist"
    end
  end
  
  def login_create
    customer = Customer.find_by_name_and_mobilephone(params[:name].strip, params[:mobilephone].strip)
    if customer.nil?
      flash[:notice] = "用户名或密码错误，请重新登录。"
      redirect_to "/login"
    else
      session[:customer_id] = customer.id
      redirect_to "/homepage"
    end
  end
  
  def logout
      session[:customer_id] = nil
      redirect_to root_path
  end
 
  def contact_us
    @sales_laster = Sale.find(:all, :conditions => ["status = ?",Sale::STATUS[:NOMAL]],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
    @store = Store.first
  end
 
end
