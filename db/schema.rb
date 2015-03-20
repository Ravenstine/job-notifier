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

ActiveRecord::Schema.define(version: 20150318023557) do

  create_table "agents", force: :cascade do |t|
    t.string   "terms",            limit: 255
    t.integer  "location_id",      limit: 4
    t.integer  "user_id",          limit: 4
    t.boolean  "auto_send_resume", limit: 1,   default: true
    t.boolean  "active",           limit: 1,   default: true
    t.boolean  "email_updates",    limit: 1,   default: true
    t.string   "whitelist",        limit: 255
    t.string   "blacklist",        limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "name",             limit: 255
  end

  add_index "agents", ["active"], name: "index_agents_on_active", using: :btree
  add_index "agents", ["user_id"], name: "index_agents_on_user_id", using: :btree

  create_table "agents_listings", force: :cascade do |t|
    t.integer  "agent_id",    limit: 4
    t.integer  "listing_id",  limit: 4
    t.boolean  "resume_sent", limit: 1, default: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "read",        limit: 1, default: false
  end

  add_index "agents_listings", ["agent_id"], name: "index_agents_listings_on_agent_id", using: :btree
  add_index "agents_listings", ["listing_id"], name: "index_agents_listings_on_listing_id", using: :btree
  add_index "agents_listings", ["read"], name: "index_agents_listings_on_read", using: :btree

  create_table "appointments", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "person",      limit: 255
    t.string   "company",     limit: 255
    t.text     "description", limit: 65535
    t.datetime "time"
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "appointments", ["time"], name: "index_appointments_on_time", using: :btree
  add_index "appointments", ["user_id"], name: "index_appointments_on_user_id", using: :btree

  create_table "boards", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "boards", ["name"], name: "index_boards_on_name", using: :btree

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "listings", force: :cascade do |t|
    t.integer  "board_id",          limit: 4
    t.string   "remote_id",         limit: 255
    t.string   "title",             limit: 255
    t.text     "description",       limit: 65535
    t.string   "company",           limit: 255
    t.string   "url",               limit: 255
    t.string   "tags",              limit: 255
    t.string   "location",          limit: 255
    t.string   "contact_email",     limit: 255
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
  add_index "listings", ["created_at"], name: "index_listings_on_created_at", using: :btree
  add_index "listings", ["description", "title", "contact_email"], name: "description_title_contact_email", type: :fulltext
  add_index "listings", ["remote_id"], name: "index_listings_on_remote_id", using: :btree
  add_index "listings", ["updated_at"], name: "index_listings_on_updated_at", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "city",              limit: 255
    t.string   "county",            limit: 255
    t.string   "state",             limit: 255
    t.string   "country",           limit: 255
    t.string   "zip_code",          limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "craigslist_prefix", limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "max_agents",             limit: 4,   default: 5
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "image",                  limit: 255
    t.string   "linked_in",              limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "appointments", "users"
  add_foreign_key "identities", "users"
end
