class AddUpdatedAtToTables < ActiveRecord::Migration
  def change
    add_column :cities, :created_at, :datetime
    add_column :cities, :updated_at, :datetime
    add_column :prod_mat_relations, :updated_at, :datetime
    add_column :prod_mat_relations, :created_at, :datetime
    add_column :car_nums, :updated_at, :datetime
    add_column :customer_num_relations, :updated_at, :datetime
    add_index :cities, :updated_at
    add_index :prod_mat_relations, :updated_at
    add_index :car_nums, :updated_at
    add_index :customer_num_relations, :updated_at
  end
end
