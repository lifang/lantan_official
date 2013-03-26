module HomepageHelper
 def province#省份
   City.find_by_sql("select * from cities where parent_id = 0")
 end

 def current_customer
   Customer.find(session[:customer_id]) if session[:customer_id]
 end
end
