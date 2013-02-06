#encoding: utf-8
class ReservationsController < ApplicationController  #预约
  layout 'frontdoor'
  def new
    @reservation = Reservation.new
    @store = Store.find(params[:store_id])
    @services = Product.find_all_by_is_service_and_store_id(Product::IS_SERVICE[:YES],params[:store_id].to_i)
    @products = Product.find_all_by_is_service_and_store_id(Product::IS_SERVICE[:NO],params[:store_id].to_i)
    @laster_sales = Sale.find(:all,
      :conditions => ["store_id = ? and status =?",@store.id,Sale::STATUS[:NOMAL]],
      :order=>"started_at desc", :limit => Sale::LASTER_SALES)
  end
  
  def create
    
    @store = Store.find(params[:store_id])
    @reservation = Reservation.new(:car_num_id => params[:car_number], :res_time => params[:res_time],
      :store_id => params[:store_id], :status => Reservation::DEFAULT_STATUS)
    if @reservation.save #往预约表中插入数据
      @car_num = CarNum.new(:num => params[:car_number])
      if @car_num.save#将车牌号插入车牌-型号表中
        @customer = Customer.new(:name => params[:customer_name], :mobilephone => params[:telephone])        
        if @customer.save#往客户表中插入数据
          @customer_num_relation = CustomerNumRelation.new(:customer_id => @customer.id, :car_num_id => @car_num.id)         
          if @customer_num_relation.save#往客户-车牌表中插入数据
            params[:select_service].each do |s|
              @res_prod_relation = ResProdRelation.create(:product_id => s, :reservation_id => @reservation.id) #往预约-产品表中插入数据
            end          
          end
        end
      end
    end
    @laster_sales = Sale.find(:all,
      :conditions => ["store_id = ? and status =?",@store.id,Sale::STATUS[:NOMAL]],
      :order=>"started_at desc", :limit => Sale::LASTER_SALES)
  end
end
