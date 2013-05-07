#encoding: utf-8
class HomepageController < ApplicationController  #总部控制器
  layout 'headquarter', :except => [:index, :login, :regist, :regist_create]
  def index 
    @news = New.find(:all, :conditions => "status = '#{New::STATUS[:NOMAL]}'",
      :order => "created_at desc", :limit => 6)
    @services = Product.find(:all, :select => "id, name, types", :conditions => ["is_service = ? and status = ?",
        Product::IS_SERVICE[:YES], Product::STATUS[:NOMAL]]).group_by { |s| s.types }

  end

  def regist_create 
    Customer.transaction do
      @customer = Customer.new(:name => params[:name].strip,:mobilephone =>  params[:mobilephone].strip,
        :address => params[:address].strip, :status => Customer::STATUS[:NOMAL],
        :types => Customer::TYPES[:NORMAL], :username => params[:username].strip, :password => params[:password].strip)
      @customer.encrypt_password
      @car_num = params[:car_num].strip
      if @customer.save
        car_num_record = CarNum.find_by_num(params[:car_num].strip)
        if car_num_record.nil?
          car_num = CarNum.create(:num => params[:car_num].strip)
          CustomerNumRelation.create(:customer_id => @customer.id, :car_num_id => car_num.id)
        else
          customer_num_relation = car_num_record.customer_num_relation
          customer_num_relation.update_attribute(:customer_id, @customer.id) if customer_num_relation
        end
        session[:customer_id] = @customer.id
      else
        flash.now[:notice] = @customer.errors.messages.map{|key,value|value.join(",")}.join("<br/>").html_safe()
        render :action => :regist
      end
    end
  end
  
  def login_create
    customer = Customer.find_by_username(params[:user_name])
    if customer.nil? or !customer.has_password?(params[:user_password])
      flash.now[:notice] = "用户名或密码错误，请重新登录!"
      @username = params[:user_name]
      render :action => :login, :layout => false
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
