class PortfoliosStocks < ActiveRecord::Migration
  def change
    create_table :portfolios_stocks do |t|
      t.references :stock
      t.references :user
    end
  end
end
