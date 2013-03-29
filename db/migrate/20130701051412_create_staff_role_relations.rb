class CreateStaffRoleRelations < ActiveRecord::Migration
  def change
    create_table :staff_role_relations do |t|
      t.integer :role_id
      t.integer :staff_id
      t.datetime :created_at
    end

    add_index :staff_role_relations, :role_id
    add_index :staff_role_relations, :staff_id
    add_index :staff_role_relations, :created_at
  end
end
