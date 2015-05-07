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

ActiveRecord::Schema.define(version: 20150430213709) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accreditations", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role"
    t.text     "description"
  end

  create_table "accreditations_courses", force: true do |t|
    t.integer  "course_id"
    t.integer  "accreditation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accreditations_courses", ["accreditation_id"], name: "index_accreditations_courses_on_accreditation_id", using: :btree
  add_index "accreditations_courses", ["course_id"], name: "index_accreditations_courses_on_course_id", using: :btree

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "course_sessions", force: true do |t|
    t.integer  "course_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "duration"
  end

  add_index "course_sessions", ["course_id"], name: "index_course_sessions_on_course_id", using: :btree

  create_table "courses", force: true do |t|
    t.string   "name"
    t.integer  "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.boolean  "for_sales_engineer"
    t.boolean  "for_sales"
    t.boolean  "for_delivery"
    t.integer  "session_type"
    t.string   "duration"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.boolean  "notifications_on"
    t.boolean  "finished"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["course_id"], name: "index_subscriptions_on_course_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "country"
    t.string   "partner"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email_token"
  end

end
