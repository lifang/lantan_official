#encoding: utf-8
class HomepageController < ApplicationController  #总部控制器
  layout 'headquarter', :except => [:index, :login, :regist, :regist_create]
  def index #总部首页
    @news = New.find(:all, :conditions => "status = '#{New::DEFAULT_STATUS}'", :order => "created_at desc", :limit => 6) #首页显示的6条新闻
    services = Product.find_all_by_is_service_and_store_id(Product::IS_SERVICE[:YES],Store::DEFAULT_ID) #首页显示的服务项目
    @service_hash = {}
    Product::SERVICE_TYPES.each_key do |key|  #将Product类里面的服务类别迭代并将Products表中的数据按类别划分
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

  def regist  #用户注册
    @customer = Customer.new
     @current_url = params[:current_url]
  end

  def regist_create #注册验证
    if Customer.find_by_name_and_mobilephone(params[:name].strip, params[:mobilephone].strip).nil?
      customer = Customer.new(:name => params[:name].strip,:mobilephone =>  params[:mobilephone].strip, :address => params[:address].strip)
      if customer.save #往用户表中插入数据
        car_num = CarNum.create(:num => params[:car_num].strip) #往车牌号表中插入数据
        CustomerNumRelation.create(:customer_id => customer.id, :car_num_id => car_num.id)#往用户-车牌-关系表中插入数据
        session[:customer] = customer
        session[:customer_id] = customer.id
        @current_url = params[:current_url]
      end
    else
      redirect_to "/homepage/regist"
    end
  end
  
  def login       #登录页面
    @current_url = params[:current_url]
  end
  
  def login_create #登录验证
    customer = Customer.find_by_name_and_mobilephone(params[:name].strip, params[:mobilephone].strip)
    if customer.nil?
      redirect_to "/homepage/login"
    else
      session[:customer] = customer
      session[:customer_id] = customer.id
      redirect_to params[:current_url]
    end
  end
  
  def logoff    #注销
    session[:customer] = nil
    redirect_to params[:current_url]
  end
  
  def about_lantan  #关于澜泰
    redirect_to "/homepage/company_introduce"
  end
 

  def contact_us #联系我们
    @sales_laster = Sale.find(:all, :conditions => ["status = ?",Sale::STATUS[:NOMAL]],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
    @store = Store.find(1)

  end
  def provincechange
    options = "<option value='0'>--请选择--</option>"
    city = City.where("parent_id = ?",params[:id]).all
    puts city.size
    city.each do |c|
      options << "<option value=#{c.id}>#{c.name}</option>"
    end
    render :text => options
  end

  def citychange
    items = ""
    stores = Store.where("city_id = ?",params[:id]).all
    stores.each do |s|
      items << "<a href = '/stores/#{s.id}'><li value=#{s.id}>#{s.name}</li></a>"
    end
    render :text => items
  end
  
 
end
