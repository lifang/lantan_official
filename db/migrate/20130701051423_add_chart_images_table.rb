class AddChartImagesTable < ActiveRecord::Migration
  create_table :chart_images do |t|
    t.integer :city_id
    t.datetime :current_month
    t.string :image_url
    t.datetime :created_at
  end
  add_index :chart_images, :city_id
  add_index :chart_images, :current_month
  add_index :chart_images, :image_url
end
