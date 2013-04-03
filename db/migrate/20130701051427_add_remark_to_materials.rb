class AddRemarkToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :remark, :string
  end
end
