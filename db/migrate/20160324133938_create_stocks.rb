class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :name, null: false
      t.string :symbol, null: false
      t.decimal :price, :precision => 14, :scale => 2
      t.integer :volatility

      t.timestamps null: false
    end
  end
end
