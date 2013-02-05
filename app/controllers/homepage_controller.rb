#encoding: utf-8
class HomepageController < ApplicationController  #总部控制器
  layout 'headquarter', :except => [:index, :login, :regist]
  def index #总部首页
    @current_url = request.path     #用户当前所浏览的页面地址，用于当用户登录后跳转到登录前所浏览的页面
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
     @current_url = params[:current_url]
  end

  def regist_create #注册验证
    customer = Customer.new(:name => params[:name],:mobilephone =>  params[:mobilephone], :address => params[:address])
    if customer.save #往用户表中插入数据
      CarNum.create(:num => params[:car_num])
      session[:customer] = customer
      @current_url = params[:current_url]
    end
  end
  
  def login       #登录页面
    @current_url = params[:current_url]
  end
  
  def login_create #登录验证
    customer = Customer.find_by_name_and_mobilephone(params[:name], params[:mobilephone])
    if customer.nil?
      redirect_to "/homepage/login"
    else
      session[:customer] = customer
      redirect_to params[:current_url]
    end
  end
  
  def logoff    #注销
    session[:customer] = nil
    redirect_to params[:current_url]
  end
  
  def about_lantan  #关于澜泰
    @current_url = request.path
    redirect_to "/homepage/company_introduce"
  end
  
  def company_introduce #公司介绍
   
    @current_url = request.path
  end
  
  def characteristic_service  #特色服务
   
    @current_url = request.path
  end
  
  def managment_idea #经营理念
   
    @current_url = request.path
  end
  
  def company_culture #企业文化
  
    @current_url = request.path
  end
  
  def team_introduce #团队介绍
 
    @current_url = request.path
  end
  
  def store_introduce #门店介绍
   
    @current_url = request.path
  end
  
  def sales_promotion #活动促销
   
  end
  
  def show_sale #活动促销详情
   
  end
  
  def product_information  #产品信息
    
    @current_url = request.path
  end
  
  def sv_cards  #储值卡
  
    @current_url = request.path
  end
  
  def news_centre #新闻中心
   
  end

  def show_new#新闻详情
    
  end

  def customer_investigate  #用户调查
    @current_url = request.path
  end

  def contact_us #联系我们
    @sales_laster = Sale.find(:all, :conditions => ["status = ?",Sale::STATUS[:NOMAL]],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
    @store = Store.find(1)
    @current_url = request.path
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
