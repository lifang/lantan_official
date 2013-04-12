# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Menu.create(:id => 1,:controller => "operate_manage",:name => "运营管理")
Menu.create(:id => 2,:controller => "logistics_manage",:name => "物流管理")
Menu.create(:id => 3,:controller => "service_manage",:name => "服务管理")
Menu.create(:id => 4,:controller => "market_manage",:name => "营销管理")
Menu.create(:id => 5,:controller => "base_datas",:name => "基础数据")

Role.create(:id => 1,:name => "系统管理员")
Role.create(:id => 2,:name => "老板")
Role.create(:id => 3,:name => "仓库管理员")
Role.create(:id => 4,:name => "客服")
