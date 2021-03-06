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

ActiveRecord::Schema.define(version: 20170227002626) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "accreditation_suggestions", force: true do |t|
    t.integer  "accreditation_id"
    t.integer  "suggestion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accreditation_suggestions", ["accreditation_id"], name: "index_accreditation_suggestions_on_accreditation_id", using: :btree

  create_table "accreditation_translations", force: true do |t|
    t.integer  "accreditation_id", null: false
    t.string   "locale",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
  end

  add_index "accreditation_translations", ["accreditation_id"], name: "index_accreditation_translations_on_accreditation_id", using: :btree
  add_index "accreditation_translations", ["locale"], name: "index_accreditation_translations_on_locale", using: :btree

  create_table "accreditations", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role"
    t.string   "tags"
    t.integer  "category"
    t.boolean  "advanced",         default: false
    t.boolean  "is_certification", default: false
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

  create_table "contacts", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "partner_id"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["partner_id"], name: "index_contacts_on_partner_id", using: :btree

  create_table "course_products", force: true do |t|
    t.integer "product_id"
    t.integer "course_id"
  end

  add_index "course_products", ["course_id"], name: "index_course_products_on_course_id", using: :btree
  add_index "course_products", ["product_id"], name: "index_course_products_on_product_id", using: :btree

  create_table "course_sessions", force: true do |t|
    t.integer  "course_id"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_sessions", ["course_id"], name: "index_course_sessions_on_course_id", using: :btree

  create_table "course_translations", force: true do |t|
    t.integer  "course_id",   null: false
    t.string   "locale",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "description"
  end

  add_index "course_translations", ["course_id"], name: "index_course_translations_on_course_id", using: :btree
  add_index "course_translations", ["locale"], name: "index_course_translations_on_locale", using: :btree

  create_table "courses", force: true do |t|
    t.integer  "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "for_sales_engineer"
    t.boolean  "for_sales"
    t.boolean  "for_delivery"
    t.integer  "session_type"
    t.decimal  "duration"
    t.string   "external_id"
  end

  add_index "courses", ["external_id"], name: "index_courses_on_external_id", using: :btree

  create_table "partners", force: true do |t|
    t.string   "name"
    t.string   "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string  "name"
    t.integer "category"
    t.string  "logo_url"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.boolean  "notifications_on"
    t.boolean  "finished"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "accreditation_id"
  end

  add_index "subscriptions", ["accreditation_id"], name: "index_subscriptions_on_accreditation_id", using: :btree
  add_index "subscriptions", ["course_id"], name: "index_subscriptions_on_course_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "country"
    t.string   "partner_name"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email_token"
    t.string   "name"
    t.integer  "partner_id"
  end

  add_index "users", ["partner_id"], name: "index_users_on_partner_id", using: :btree

end
