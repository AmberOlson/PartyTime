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

ActiveRecord::Schema.define(version: 20160824220643) do

  create_table "comments", force: true do |t|
    t.text     "text"
    t.integer  "event_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["event_id"], name: "index_comments_on_event_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "events", force: true do |t|
    t.string   "title"
    t.date     "date"
    t.time     "time"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provence"
    t.string   "city"
    t.string   "route"
    t.integer  "street_number"
    t.string   "country"
    t.string   "postal_code"
    t.string   "lat"
    t.string   "lng"
  end

  create_table "memberships", force: true do |t|
    t.boolean  "admin",             default: false
    t.string   "status",            default: "Invited"
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitiation_token"
  end

  add_index "memberships", ["user_id", "event_id"], name: "index_memberships_on_user_id_and_event_id", unique: true

  create_table "relationships", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "friend"
    t.integer  "user_id"
    t.string   "classification", default: "Other"
  end

  add_index "relationships", ["user_id", "friend"], name: "index_relationships_on_user_id_and_friend", unique: true

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "picture"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
