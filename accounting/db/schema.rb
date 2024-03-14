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

ActiveRecord::Schema[7.0].define(version: 2024_03_09_234145) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email"
    t.uuid "public_id"
    t.string "full_name"
    t.string "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "auth_identities", force: :cascade do |t|
    t.string "uid"
    t.string "provider", null: false
    t.string "login", null: false
    t.string "token"
    t.string "password_hash"
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_auth_identities_on_account_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount"
    t.string "currency"
    t.string "type"
    t.bigint "task_id", null: false
    t.bigint "account_id", null: false
    t.bigint "wallet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_payments_on_account_id"
    t.index ["task_id"], name: "index_payments_on_task_id"
    t.index ["wallet_id"], name: "index_payments_on_wallet_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.integer "status", default: 0, null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "wallets", force: :cascade do |t|
    t.decimal "balance"
    t.string "currency"
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_wallets_on_account_id"
  end

  add_foreign_key "auth_identities", "accounts"
  add_foreign_key "payments", "accounts"
  add_foreign_key "payments", "tasks"
  add_foreign_key "payments", "wallets"
  add_foreign_key "wallets", "accounts"
end
