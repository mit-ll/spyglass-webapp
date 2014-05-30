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

ActiveRecord::Schema.define(version: 20140530143814) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "keys", force: true do |t|
    t.integer  "user_id"
    t.string   "keyname"
    t.text     "sshkey"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sha1hash"
  end

  add_index "keys", ["user_id"], name: "index_keys_on_user_id", using: :btree

  create_table "sessions", force: true do |t|
    t.integer  "user_id"
    t.integer  "key_id"
    t.string   "container_host"
    t.string   "container_port"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "container_hashid"
  end

  create_table "users", force: true do |t|
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "use_yubikey"
    t.string   "registered_yubikey"
    t.string   "login"
    t.integer  "roles_mask"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
