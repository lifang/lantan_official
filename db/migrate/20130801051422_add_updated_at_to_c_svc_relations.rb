class AddUpdatedAtToCSvcRelations < ActiveRecord::Migration
  def change
    add_column :c_svc_relations, :updated_at, :datetime
    add_column :svcard_prod_relations, :created_at, :datetime
    add_column :svcard_prod_relations, :updated_at, :datetime

    add_index :c_svc_relations, :updated_at
    add_index :svcard_prod_relations, :created_at
    add_index :svcard_prod_relations, :updated_at
  end
end
