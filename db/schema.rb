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

ActiveRecord::Schema.define(version: 20150307203314) do

  create_table "agents", force: :cascade do |t|
    t.string   "terms",      limit: 255
    t.string   "location",   limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "boards", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "listings", force: :cascade do |t|
    t.integer  "board_id",          limit: 4
    t.string   "remote_id",         limit: 255
    t.string   "title",             limit: 255
    t.text     "description",       limit: 65535
    t.string   "company",           limit: 255
    t.string   "url",               limit: 255
    t.string   "tags",              limit: 255
    t.string   "location",          limit: 255
    t.boolean  "remote",            limit: 1,     default: false
    t.boolean  "offers_relocation", limit: 1,     default: false
    t.boolean  "full_time",         limit: 1,     default: false
    t.boolean  "part_time",         limit: 1,     default: false
    t.boolean  "contract",          limit: 1,     default: false
    t.boolean  "freelance",         limit: 1,     default: false
    t.boolean  "internship",        limit: 1,     default: false
    t.boolean  "moonlighting",      limit: 1,     default: false
    t.boolean  "telecommute",       limit: 1,     default: false
    t.datetime "posted_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.integer  "agent_id",          limit: 4
  end

  add_index "listings", ["agent_id"], name: "index_listings_on_agent_id", using: :btree

end
