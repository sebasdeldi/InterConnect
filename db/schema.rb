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

ActiveRecord::Schema.define(version: 20180611200619) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "fcl_exw_cargo_infos", force: :cascade do |t|
    t.bigint "operation_id"
    t.string "loading_address"
    t.string "container_size"
    t.date "loading_date"
    t.time "loading_time"
    t.float "gross_weight"
    t.text "commercial_description"
    t.string "cargo_hazardous"
    t.string "hazardous_document"
    t.string "schedule_b_number"
    t.string "ein"
    t.string "pickup_reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operation_id"], name: "index_fcl_exw_cargo_infos_on_operation_id"
  end

  create_table "functionalities", force: :cascade do |t|
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_functionalities_on_role_id"
  end

  create_table "general_cargo_infos", force: :cascade do |t|
    t.bigint "operation_id"
    t.integer "pieces_number"
    t.string "invoice"
    t.string "packing_list"
    t.string "tax_id"
    t.string "pv_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operation_id"], name: "index_general_cargo_infos_on_operation_id"
  end

  create_table "operations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "modality"
    t.string "status"
    t.float "steps_number"
    t.float "current_step"
    t.boolean "fcl_exw_info_requested", default: false
    t.boolean "fcl_exw_info_confirmed", default: false
    t.boolean "fcl_exw_quotation_confirmed", default: false
    t.string "status_message", default: " "
  end

  create_table "operations_by_users", force: :cascade do |t|
    t.bigint "agent_id"
    t.bigint "shipper_id"
    t.bigint "representative_id"
    t.bigint "operation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_operations_by_users_on_agent_id"
    t.index ["operation_id"], name: "index_operations_by_users_on_operation_id"
    t.index ["representative_id"], name: "index_operations_by_users_on_representative_id"
    t.index ["shipper_id"], name: "index_operations_by_users_on_shipper_id"
  end

  create_table "pieces", force: :cascade do |t|
    t.string "sort"
    t.decimal "weight"
    t.decimal "height"
    t.decimal "width"
    t.decimal "depth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "general_cargo_info_id"
    t.index ["general_cargo_info_id"], name: "index_pieces_on_general_cargo_info_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "note"
    t.string "status", default: "PENDING"
    t.date "due_date"
    t.bigint "operation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operation_id"], name: "index_tasks_on_operation_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "company_name"
    t.string "contact_first_name"
    t.string "contact_last_name"
    t.string "phone_number"
    t.string "address"
    t.string "state"
    t.string "country"
    t.string "city"
    t.string "account_type"
    t.string "zip_code"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "outlook_password"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "fcl_exw_cargo_infos", "operations"
  add_foreign_key "functionalities", "roles"
  add_foreign_key "general_cargo_infos", "operations"
  add_foreign_key "operations_by_users", "operations"
  add_foreign_key "pieces", "general_cargo_infos"
  add_foreign_key "tasks", "operations"
  add_foreign_key "users", "roles"
end
