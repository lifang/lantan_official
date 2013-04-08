class ChangeTyprOfStatusOfChartImages < ActiveRecord::Migration
  def change
    change_column :news, :status, :integer
  end
end
