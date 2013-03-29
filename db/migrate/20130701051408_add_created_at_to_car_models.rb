class AddCreatedAtToCarModels < ActiveRecord::Migration
  def change
    add_column :car_models, :created_at, :datetime
    add_index :car_models, :created_at
  end
end
