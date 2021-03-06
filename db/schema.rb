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

ActiveRecord::Schema.define(version: 20150616092831) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
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

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "call_center_answers", force: :cascade do |t|
    t.integer "lead_id"
    t.string  "op_decline"
    t.string  "calc_calorie_box"
    t.string  "calorie_box"
    t.string  "deliv_address"
    t.string  "deliv_date"
    t.string  "price"
    t.string  "age"
    t.string  "height"
    t.string  "current_weight"
    t.string  "desired_weight"
    t.string  "fiz_load_level"
    t.string  "day_eat_count"
    t.string  "day_nosh_count"
    t.string  "activity_level"
    t.string  "osobiy_status"
    t.string  "food_allergies"
    t.string  "disease"
    t.string  "vitamins_supplements"
    t.text    "comment"
  end

  create_table "leads", force: :cascade do |t|
    t.integer  "bitrix_id"
    t.string   "title"
    t.string   "state"
    t.string   "sub_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "page"
    t.string   "source"
    t.string   "campaign"
    t.string   "medium"
    t.string   "term"
    t.string   "refid"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "offer"
    t.string   "geo"
    t.string   "age"
    t.string   "gender"
    t.string   "placement"
    t.string   "phone"
  end

  create_table "pages", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "full_text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
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
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "refid"
    t.string   "last_name"
    t.string   "phone"
    t.string   "group"
    t.string   "company"
    t.string   "offline"
    t.string   "source"
    t.string   "payment"
    t.text     "comment"
    t.string   "authentication_token"
    t.string   "post_back_url"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
