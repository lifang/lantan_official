class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.datetime :created_at
    end

    add_index :roles, :created_at
  end
end
