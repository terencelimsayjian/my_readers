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

ActiveRecord::Schema.define(version: 20171228064803) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diagnostics", force: :cascade do |t|
    t.bigint "student_id"
    t.integer "index", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["student_id"], name: "index_diagnostics_on_student_id"
  end

  create_table "facilitators", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "full_name", null: false
    t.string "school", null: false
    t.string "district", null: false
    t.integer "state", null: false
    t.string "phone_number", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_facilitators_on_email", unique: true
    t.index ["invitation_token"], name: "index_facilitators_on_invitation_token", unique: true
    t.index ["reset_password_token"], name: "index_facilitators_on_reset_password_token", unique: true
  end

  create_table "levels", force: :cascade do |t|
    t.integer "reading_level"
    t.integer "number_of_tested_words"
    t.integer "phonics_score"
    t.integer "fluency_score"
    t.integer "comprehension_score"
    t.bigint "diagnostic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diagnostic_id"], name: "index_levels_on_diagnostic_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "facilitator_id"
    t.string "name", null: false
    t.date "estimated_start_date", null: false
    t.date "estimated_end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["facilitator_id"], name: "index_projects_on_facilitator_id"
  end

  create_table "students", force: :cascade do |t|
    t.bigint "project_id"
    t.string "name", null: false
    t.string "class_name", null: false
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_students_on_project_id"
  end

  add_foreign_key "diagnostics", "students"
  add_foreign_key "levels", "diagnostics"
  add_foreign_key "students", "projects"
end
