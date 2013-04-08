#encoding: utf-8
class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :controller
      t.string :name
      t.datetime :created_at
    end

    Menu.create(:id => 1,:controller => "operate_manage",:name => "运营管理")
    Menu.create(:id => 2,:controller => "logistics_manage",:name => "物流管理")
    Menu.create(:id => 3,:controller => "service_manage",:name => "服务管理")
    Menu.create(:id => 4,:controller => "market_manage",:name => "营销管理")
    Menu.create(:id => 5,:controller => "base_datas",:name => "基础数据")

    add_index :menus, :controller
    add_index :menus, :created_at
  end
end
