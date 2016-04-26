class AddColumnsToHoldings < ActiveRecord::Migration
  def change
    add_column :holdings, :stock_price, :decimal, :precision =>12, :scale => 2
  end
end
