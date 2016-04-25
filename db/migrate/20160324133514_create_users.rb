class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      # t.string :email, null: false
      # t.string :password_digest, null: false
      t.decimal :cash, :precision => 999, :scale => 2, :default => 1000

      t.timestamps null: false
    end
  end
end
