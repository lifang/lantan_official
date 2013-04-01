class CreateRoleModelRelations < ActiveRecord::Migration
  def change
    create_table :role_model_relations do |t|
      t.integer :role_id
      t.integer :num
      t.datetime :created_at
    end

    add_index :role_model_relations, :role_id
    add_index :role_model_relations, :created_at
  end
end
