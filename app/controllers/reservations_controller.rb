#encoding: utf-8
class ReservationsController < ApplicationController  #预约
  layout 'frontdoor'
  def new
    @store = SStore.find(params[:store_id].to_i)
    @services = SProduct.find_all_by_is_service_and_store_id_and_status(Product::IS_SERVICE[:YES],params[:store_id].to_i,Product::STATUS[:NOMAL])
  end
  
  def create
    @store = SStore.find(params[:store_id].to_i)
    Reservation.transaction do
      @car_num = CarNum.find_or_create_by_num(params[:car_number].strip)
      @customer = Customer.find_or_create_by_name_and_mobilephone(params[:customer_name].strip, params[:telephone].strip)
      @customer_num_relation = CustomerNumRelation.find_or_create_by_customer_id_and_car_num_id(@customer.id, @car_num.id)
      res_time = params[:res_day].strip+" "+params[:res_hour]+":"+params[:res_mins]+":00"
      @reservation = Reservation.create(:car_num_id => @car_num.id,
        :res_time => res_time, :store_id => @store.id, :status => Reservation::STATUS[:NOMAL])
      params[:select_service].each do |s|
        @res_prod_relation = ResProdRelation.create(:product_id => s, :reservation_id => @reservation.id)
      end
    end
  end
end
