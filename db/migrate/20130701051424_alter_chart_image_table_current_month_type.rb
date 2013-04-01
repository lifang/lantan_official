class AlterChartImageTableCurrentMonthType < ActiveRecord::Migration
  def up
    change_column :chart_images, :current_month, :integer
  end

  def down
    change_column :chart_images, :current_month, :datetime
  end
end
