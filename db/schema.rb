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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120131020250) do

  create_table "active_admin_comments", :force => true do |t|
    t.integer   "resource_id",   :null => false
    t.string    "resource_type", :null => false
    t.integer   "author_id"
    t.string    "author_type"
    t.text      "body"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string    "email",                                 :default => "", :null => false
    t.string    "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",                         :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "bands", :force => true do |t|
    t.string   "name"
    t.string   "last_fm_id"
    t.string   "wikipedia_id"
    t.string   "homepage_url"
    t.text     "bio"
    t.boolean  "is_editors_choice"
    t.text     "editors_choice_note"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_local"
  end

  create_table "bands_events", :id => false, :force => true do |t|
    t.integer "band_id"
    t.integer "event_id"
  end

  create_table "cities", :force => true do |t|
    t.string    "name"
    t.string    "abbreviation"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "event_datetime"
    t.string   "ticket_status"
    t.integer  "venue_id"
    t.boolean  "is_editors_choice"
    t.text     "editors_choice_note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "neighborhoods", :force => true do |t|
    t.integer   "city_id"
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "tickets", :force => true do |t|
    t.integer   "event_id"
    t.string    "seller_url"
    t.float     "price"
    t.integer   "quantity"
    t.string    "description"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.float     "min_price"
    t.float     "max_price"
  end

  create_table "venues", :force => true do |t|
    t.string    "name"
    t.string    "homepage_url"
    t.string    "wikipedia_id"
    t.string    "address"
    t.string    "city_address"
    t.string    "state"
    t.integer   "zip"
    t.text      "description"
    t.boolean   "is_editors_choice"
    t.text      "editors_choice_note"
    t.string    "phone"
    t.integer   "city_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "neighborhood_id"
    t.float     "ticket_min_price"
    t.float     "ticket_max_price"
  end

end
