class CreateMatOutOrders < ActiveRecord::Migration
  def change
    create_table :mat_out_orders do |t|
      t.integer :material_id
      t.integer :staff_id
      t.integer :material_num
      t.float :price
      t.integer :material_order_id

      t.datetime :created_at
    end

    add_index :mat_out_orders, :material_id
    add_index :mat_out_orders, :staff_id
    add_index :mat_out_orders, :material_order_id
    add_index :mat_out_orders, :created_at
  end
end
