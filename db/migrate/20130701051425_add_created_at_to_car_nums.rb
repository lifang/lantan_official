class AddCreatedAtToCarNums < ActiveRecord::Migration
  def change
    add_column :car_nums, :created_at, :datetime
    add_column :customer_num_relations, :created_at, :datetime
    add_index :car_nums, :created_at
    add_index :customer_num_relations, :created_at
  end
end
