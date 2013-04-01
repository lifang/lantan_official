class AddSyncsTable < ActiveRecord::Migration
  #打折卡
  def change
    create_table :syncs do |t|
      t.datetime :sync_at
      t.string :zip_name
      t.boolean :sync_status
      t.datetime :created_at
    end
  end
end
