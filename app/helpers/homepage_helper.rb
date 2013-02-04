module HomepageHelper
 def province#省份
   City.find_by_sql("select * from cities where parent_id = 0")
 end
end
