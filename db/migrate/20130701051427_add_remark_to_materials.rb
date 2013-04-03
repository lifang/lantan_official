class AddRemarkToMaterials < ActiveRecord::Migration
  def change
    add_column :materials, :remark, :string, :limit => 1000
    add_column :materials, :check_num, :integer
  end
end
