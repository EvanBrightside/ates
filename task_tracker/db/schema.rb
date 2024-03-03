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

ActiveRecord::Schema[7.0].define(version: 2024_03_03_180244) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "auth_identity_providers", ["auth"]
  create_enum "task_statuses_list", ["created", "done"]

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

  create_table "task_statuses", force: :cascade do |t|
    t.string "status", null: false
    t.string "comment"
    t.bigint "account_id", null: false
    t.bigint "task_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_task_statuses_on_account_id"
    t.index ["task_id"], name: "index_task_statuses_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "status", default: 0, null: false
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_tasks_on_account_id"
  end

  add_foreign_key "auth_identities", "accounts"
  add_foreign_key "task_statuses", "accounts"
  add_foreign_key "task_statuses", "tasks"
  add_foreign_key "tasks", "accounts"
end
