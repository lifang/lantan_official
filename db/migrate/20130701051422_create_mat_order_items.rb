class CreateMatOrderItems < ActiveRecord::Migration
  def change
    create_table :mat_order_items do |t|
      t.integer :material_order_id
      t.integer :material_id
      t.integer :material_num
      t.float :price

    end

    add_index :mat_order_items, :material_order_id
    add_index :mat_order_items, :material_id
  end
end
