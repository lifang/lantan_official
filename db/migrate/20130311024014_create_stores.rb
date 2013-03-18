class CreateStores < ActiveRecord::Migration
  #门店表
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :contact   #门店联系人
      t.string :email
      t.string :position   #门店坐标
      t.string :introduction #门店介绍
      t.string :img_url
      t.datetime :opened_at
      t.float :account  #门店账户余额


      t.timestamps
    end

    add_index :stores, :created_at
  end
end
