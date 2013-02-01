class HomepageController < ApplicationController  #总部控制器
  layout 'headquarter', :except => [:index, :login]
  def index #总部首页
    @current_url = request.path     #用户当前所浏览的页面地址，用于当用户登录后跳转到登录前所浏览的页面
  end
  def login       #登录页面
     @current_url = params[:current_url]
  end
  def create_customer_session #登录验证
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
    @current_url = request.path
  end
  def product_information  #产品信息
    @current_url = request.path
  end
  def sv_cards  #储值卡
    @current_url = request.path
  end
  def news_centre #新闻中心
    @current_url = request.path
  end
  def customer_investigate  #用户调查
    @current_url = request.path
  end
  def contact_us #联系我们
    @current_url = request.path
  end

end
