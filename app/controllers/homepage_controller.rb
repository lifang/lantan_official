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
  
  def product_information  #产品信息
       @sales_laster = Sale.find(:all, :conditions => ["status = ? and store_id = ?",Sale::STATUS[:NOMAL],Store::DEFAULT_ID],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
       @products = Product.find_all_by_is_service_and_store_id(Product::IS_SERVICE[:NO],Store::DEFAULT_ID).paginate(
      :page => params[:page],:per_page => 8,:order => "created_at desc")
    #总店的产品信息
  end
  def product_detail  #产品信息详情
    @product = Product.find(params[:id])
      @sales_laster = Sale.find(:all, :conditions => ["status = ? and store_id = ?",Sale::STATUS[:NOMAL],Store::DEFAULT_ID],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
  end
  def sv_cards  #储值卡
  

  end
  
  def customer_investigate  #用户调查

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
