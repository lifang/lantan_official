module ApplicationHelper
  include Constant
  
  def show_time(time)
    time.strftime('%Y-%m-%d')
  end
  def is_have?()#判断文件是否存在
   
  end
  #最新活动
  def sales_laster
    Sale.find(:all, :conditions => ["status = ?",Sale::STATUS[:NOMAL]],
      :order => "created_at desc", :limit => Sale::NEW_NUM)
  end
  def current_user
    Customer.find(session[:customer_id])
  end
  
end