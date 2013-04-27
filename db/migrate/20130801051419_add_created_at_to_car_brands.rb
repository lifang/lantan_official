class AddCreatedAtToCarBrands < ActiveRecord::Migration
  def change
    add_column :car_brands, :created_at, :datetime
  end
end
