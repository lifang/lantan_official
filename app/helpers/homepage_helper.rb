module HomepageHelper
 def province#省份
   City.find_by_sql("select * from cities where parent_id = 0")
 end

 def current_customer(customer_id)
   Customer.find(customer_id)
 end
end
