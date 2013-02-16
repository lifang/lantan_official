class ProductInformationController < ApplicationController
  layout 'headquarter'
  def index
     @sales_laster = Sale.find(:all, :conditions => ["status = ? and store_id = ?",Sale::STATUS[:NOMAL],Store::DEFAULT_ID],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
       @products = Product.find_all_by_is_service_and_store_id(Product::IS_SERVICE[:NO],Store::DEFAULT_ID).paginate(
      :page => params[:page],:per_page => 8,:order => "created_at desc")
  end

  def show
    @product = Product.find(params[:id])
      @sales_laster = Sale.find(:all, :conditions => ["status = ? and store_id = ?",Sale::STATUS[:NOMAL],Store::DEFAULT_ID],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
  end
end
