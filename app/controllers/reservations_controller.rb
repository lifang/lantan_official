#encoding: utf-8
class ReservationsController < ApplicationController
  layout 'frontdoor'
  def new
    @store = Store.find(params[:store_id].to_i)
    @services = Product.find_all_by_is_service_and_store_id(Product::IS_SERVICE[:YES],params[:store_id])
    @products = Product.find_all_by_is_service_and_store_id(Product::IS_SERVICE[:NO],params[:store_id])
    @store_id = params[:store_id]
  end
  
  def create
    @car_num = CarNum.create(:num => params[:car_number])  
    #将车牌号插入车牌-型号表中
    @reservation = Reservation.create(:car_num_id => @car_num.id, :res_time => params[:res_time],
    :store_id => params[:store_id], :status => Reservation::DEFAULT_STATUS)       
    #往预约表中插入数据
    params[:select_service].each do |s|
      @res_prod_relation = ResProdRelation.create(:product_id => s, :reservation_id => @reservation.id)  
    end
    #往预约-产品表中插入数据
    @customer = Customer.create(:name => params[:customer_name], :mobilephone => params[:telephone]) 
    #往客户表中插入数据
    @customer_num_relation = CustomerNumRelation.create(:customer_id => @customer.id, :car_num_id => @car_num.id) 
    #往客户-车牌表中插入数据

  end
end
