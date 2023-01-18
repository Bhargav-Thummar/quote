# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_01_17_100536) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bids", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id", null: false
    t.index ["company_id"], name: "index_bids_on_company_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_item_dates", force: :cascade do |t|
    t.bigint "bid_id", null: false
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bid_id"], name: "index_line_item_dates_on_bid_id"
    t.index ["date", "bid_id"], name: "index_line_item_dates_on_date_and_bid_id", unique: true
    t.index ["date"], name: "index_line_item_dates_on_date"
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "line_item_date_id", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "quantity", null: false
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["line_item_date_id"], name: "index_line_items_on_line_item_date_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "recipient_type", null: false
    t.bigint "recipient_id", null: false
    t.string "type", null: false
    t.jsonb "params"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["read_at"], name: "index_notifications_on_read_at"
    t.index ["recipient_type", "recipient_id"], name: "index_notifications_on_recipient"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id", null: false
    t.string "name"
    t.text "bio"
    t.integer "age"
    t.date "dob"
    t.string "country"
    t.string "city"
    t.string "zip"
    t.string "address"
    t.string "phone"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bids", "companies"
  add_foreign_key "line_item_dates", "bids"
  add_foreign_key "line_items", "line_item_dates"
  add_foreign_key "users", "companies"
end
