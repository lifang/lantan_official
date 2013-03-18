module ApplicationHelper
  include Constant
  
  #最新活动
  def sales_laster
    Sale.find(:all, :conditions => ["status = ?",Sale::STATUS[:RELEASE]],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
  end
  
  def current_user
    Customer.find(session[:customer_id])
  end
  
end