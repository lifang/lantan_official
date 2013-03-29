class CreateRoleMenuRelations < ActiveRecord::Migration
  def change
    create_table :role_menu_relations do |t|
      t.integer :role_id
      t.integer :menu_id
      t.datetime :created_at
    end

    add_index :role_menu_relations, :role_id
    add_index :role_menu_relations, :menu_id
    add_index :role_menu_relations, :created_at
  end
end
