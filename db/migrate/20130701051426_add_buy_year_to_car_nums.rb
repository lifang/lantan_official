class AddBuyYearToCarNums < ActiveRecord::Migration
  def change
    add_column :car_nums, :buy_year, :int
  end
end
