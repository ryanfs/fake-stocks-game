class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :cash, :default => 100
      t.references :stock, index: true

      t.timestamps null: false
    end
  end
end
