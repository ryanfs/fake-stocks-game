class CreateHoldings < ActiveRecord::Migration
  def change
    create_table :holdings do |t|
      t.integer :quantity, :default => 1
      t.references :user, index: true, foreign_key: true
      t.references :stock, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
