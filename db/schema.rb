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

ActiveRecord::Schema.define(version: 20190627200620) do

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

  create_table "fcl_exw_cargo_info_steps", force: :cascade do |t|
    t.bigint "operation_id"
    t.string "contact_email"
    t.string "contact_number"
    t.string "loading_address"
    t.date "loading_date"
    t.time "loading_time"
    t.string "schedule_b_number"
    t.string "pickup_reference"
    t.integer "pieces_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operation_id"], name: "index_fcl_exw_cargo_info_steps_on_operation_id"
  end

  create_table "fcl_exw_info_confirmed_steps", force: :cascade do |t|
    t.boolean "completed", default: false
    t.bigint "operation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operation_id"], name: "index_fcl_exw_info_confirmed_steps_on_operation_id"
  end

  create_table "fcl_exw_info_requested_steps", force: :cascade do |t|
    t.boolean "completed", default: false
    t.bigint "operation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operation_id"], name: "index_fcl_exw_info_requested_steps_on_operation_id"
  end

  create_table "fcl_exw_quotation_confirmed_steps", force: :cascade do |t|
    t.boolean "completed", default: false
    t.bigint "operation_id"
    t.text "additional_comment"
    t.float "neta"
    t.float "venta"
    t.json "files"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operation_id"], name: "index_fcl_exw_quotation_confirmed_steps_on_operation_id"
  end

  create_table "fcl_exw_request_booking_steps", force: :cascade do |t|
    t.boolean "completed", default: false
    t.bigint "operation_id"
    t.string "additional_message"
    t.integer "carrier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operation_id"], name: "index_fcl_exw_request_booking_steps_on_operation_id"
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
    t.float "pieces_number"
    t.boolean "fcl_exw_info_requested", default: false
    t.boolean "fcl_exw_info_confirmed", default: false
    t.boolean "fcl_exw_quotation_confirmed", default: false
    t.string "status_message", default: " "
    t.string "reference"
    t.string "po_number"
    t.string "reference_number"
    t.integer "secure_id"
  end

  create_table "operations_by_users", force: :cascade do |t|
    t.bigint "agent_id"
    t.bigint "shipper_id"
    t.bigint "representative_id"
    t.bigint "consignee_id"
    t.bigint "operation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_operations_by_users_on_agent_id"
    t.index ["consignee_id"], name: "index_operations_by_users_on_consignee_id"
    t.index ["operation_id"], name: "index_operations_by_users_on_operation_id"
    t.index ["representative_id"], name: "index_operations_by_users_on_representative_id"
    t.index ["shipper_id"], name: "index_operations_by_users_on_shipper_id"
  end

  create_table "pieces", force: :cascade do |t|
    t.bigint "fcl_exw_cargo_info_step_id"
    t.string "sort"
    t.float "gross_weight"
    t.text "commercial_description"
    t.string "cargo_hazardous"
    t.string "container_size"
    t.string "hazardous_class"
    t.string "un_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fcl_exw_cargo_info_step_id"], name: "index_pieces_on_fcl_exw_cargo_info_step_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "note"
    t.string "status", default: "0"
    t.date "due_date"
    t.bigint "fcl_exw_info_requested_steps_id"
    t.bigint "fcl_exw_info_confirmed_steps_id"
    t.bigint "fcl_exw_quotation_confirmed_steps_id"
    t.bigint "fcl_exw_cargo_info_steps_id"
    t.bigint "fcl_exw_request_booking_steps_id"
    t.bigint "operation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fcl_exw_cargo_info_steps_id"], name: "index_tasks_on_fcl_exw_cargo_info_steps_id"
    t.index ["fcl_exw_info_confirmed_steps_id"], name: "index_tasks_on_fcl_exw_info_confirmed_steps_id"
    t.index ["fcl_exw_info_requested_steps_id"], name: "index_tasks_on_fcl_exw_info_requested_steps_id"
    t.index ["fcl_exw_quotation_confirmed_steps_id"], name: "index_tasks_on_fcl_exw_quotation_confirmed_steps_id"
    t.index ["fcl_exw_request_booking_steps_id"], name: "index_tasks_on_fcl_exw_request_booking_steps_id"
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
    t.string "vendor_operation_mode"
    t.string "website"
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

  create_table "users_relationships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "related_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "fcl_exw_cargo_info_steps", "operations"
  add_foreign_key "fcl_exw_info_confirmed_steps", "operations"
  add_foreign_key "fcl_exw_info_requested_steps", "operations"
  add_foreign_key "fcl_exw_quotation_confirmed_steps", "operations"
  add_foreign_key "fcl_exw_request_booking_steps", "operations"
  add_foreign_key "functionalities", "roles"
  add_foreign_key "general_cargo_infos", "operations"
  add_foreign_key "operations_by_users", "operations"
  add_foreign_key "pieces", "fcl_exw_cargo_info_steps"
  add_foreign_key "tasks", "fcl_exw_cargo_info_steps", column: "fcl_exw_cargo_info_steps_id"
  add_foreign_key "tasks", "fcl_exw_info_confirmed_steps", column: "fcl_exw_info_confirmed_steps_id"
  add_foreign_key "tasks", "fcl_exw_info_requested_steps", column: "fcl_exw_info_requested_steps_id"
  add_foreign_key "tasks", "fcl_exw_quotation_confirmed_steps", column: "fcl_exw_quotation_confirmed_steps_id"
  add_foreign_key "tasks", "fcl_exw_request_booking_steps", column: "fcl_exw_request_booking_steps_id"
  add_foreign_key "tasks", "operations"
  add_foreign_key "users", "roles"
end
