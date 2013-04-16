# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#初始菜单数据
Menu.create(:id => 1,:controller => "operate_manage",:name => "运营管理")
Menu.create(:id => 2,:controller => "logistics_manage",:name => "物流管理")
Menu.create(:id => 3,:controller => "service_manage",:name => "服务管理")
Menu.create(:id => 4,:controller => "market_manage",:name => "营销管理")
Menu.create(:id => 5,:controller => "base_datas",:name => "基础数据")

#初始角色数据
Role.create(:id => 1,:name => "系统管理员")
Role.create(:id => 2,:name => "老板")
Role.create(:id => 3,:name => "仓库管理员")
Role.create(:id => 4,:name => "客服")

#门店
store = Store.create(:id => 1, :name => "杭州西湖路门店", :address => "杭州西湖路", :phone => "",
  :contact => "", :email => "", :position => "", :introduction => "", :img_url => "",
  :opened_at => Time.now, :account => 0, :created_at => Time.now, :updated_at => Time.now,
  :city_id => 1, :status => 1)
#系统管理员
staff = Staff.create(:name => "系统管理员", :type_of_w => 0, :position => 0, :sex => 1, :level => 2, :birthday => Time.now,
  :status => Staff::STATUS[:normal], :store_id => store.id, :username => "admin", :password => "123456")
staff.encrypt_password
StaffRoleRelation.create(:role_id => 1, :satff_id => staff.id)

#系统管理员菜单权限
RoleMenuRelation.create(:role_id => 1, :menu_id => 1)
RoleMenuRelation.create(:role_id => 1, :menu_id => 2)
RoleMenuRelation.create(:role_id => 1, :menu_id => 3)
RoleMenuRelation.create(:role_id => 1, :menu_id => 4)
RoleMenuRelation.create(:role_id => 1, :menu_id => 5)

#系统管理员功能权限
RoleModelRelation.create(:role_id => 1, :model_name => 'operate_manage', :num => 15)
RoleModelRelation.create(:role_id => 1, :model_name => 'logistics_manage', :num => 15)
RoleModelRelation.create(:role_id => 1, :model_name => 'service_manage', :num => 3)
RoleModelRelation.create(:role_id => 1, :model_name => 'market_manage', :num => 31)
RoleModelRelation.create(:role_id => 1, :model_name => 'base_datas', :num => 16127)