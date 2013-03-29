class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :controller
      t.string :name
      t.datetime :created_at
    end

    add_index :menus, :controller
    add_index :menus, :created_at
  end
end
