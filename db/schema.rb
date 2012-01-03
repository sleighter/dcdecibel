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

ActiveRecord::Schema.define(:version => 20120103002454) do

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
  end

  create_table "bands_events", :id => false, :force => true do |t|
    t.integer "band_id"
    t.integer "event_id"
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "venues", :force => true do |t|
    t.string   "name"
    t.string   "homepage_url"
    t.string   "wikipedia_id"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.text     "description"
    t.boolean  "is_editors_choice"
    t.text     "editors_choice_note"
    t.string   "phone"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
