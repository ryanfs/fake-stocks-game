class CreateMarkets < ActiveRecord::Migration
  def change
    create_table :markets do |t|
      t.integer :days, :default => 1
      t.references :stock, index: true

      t.timestamps null: false
    end
  end
end
