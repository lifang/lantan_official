class CreateCapitals < ActiveRecord::Migration
  def change
    create_table :capitals do |t|
      t.string :name
      t.datetime :created_at
    end
  end
end
