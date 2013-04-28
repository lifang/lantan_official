class AddCreatedAtUpdatedAt < ActiveRecord::Migration
  def change
   add_column :m_order_types, :created_at, :datetime
   add_column :m_order_types, :updated_at, :datetime
  end
end
