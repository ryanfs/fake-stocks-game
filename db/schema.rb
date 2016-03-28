# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160328203315) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "holdings", force: true do |t|
    t.integer  "quantity"
    t.integer  "user_id"
    t.integer  "stock_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "holdings", ["stock_id"], name: "index_holdings_on_stock_id", using: :btree
  add_index "holdings", ["user_id"], name: "index_holdings_on_user_id", using: :btree

  create_table "markets", force: true do |t|
    t.integer  "days",       default: 1
    t.integer  "stock_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "markets", ["stock_id"], name: "index_markets_on_stock_id", using: :btree

  create_table "portfolios_stocks", force: true do |t|
    t.integer "stock_id"
    t.integer "user_id"
  end

  create_table "stocks", force: true do |t|
    t.string   "name",       null: false
    t.integer  "price",      null: false
    t.integer  "volatility"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: true do |t|
    t.string   "username",                      null: false
    t.string   "email",                         null: false
    t.string   "password_digest",               null: false
    t.integer  "cash",            default: 100
    t.integer  "stock_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "users", ["stock_id"], name: "index_users_on_stock_id", using: :btree

end
