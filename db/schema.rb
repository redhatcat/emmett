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

ActiveRecord::Schema.define(:version => 20101031164152) do

  create_table "comments", :force => true do |t|
    t.text     "body"
    t.boolean  "is_public"
    t.string   "posted_from_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "entry_id"
  end

  add_index "comments", ["entry_id"], :name => "index_comments_on_entry_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "entries", :force => true do |t|
    t.string   "name"
    t.text     "body_text"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "text_format_id"
    t.datetime "publish_on_date"
    t.string   "tag_string"
    t.integer  "user_id"
    t.string   "state",           :default => "drafted"
    t.datetime "key_timestamp"
  end

  add_index "entries", ["state"], :name => "index_entries_on_state"
  add_index "entries", ["text_format_id"], :name => "index_entries_on_text_format_id"
  add_index "entries", ["user_id"], :name => "index_entries_on_user_id"

  create_table "tag_assignments", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entry_id"
    t.integer  "tag_id"
  end

  add_index "tag_assignments", ["entry_id"], :name => "index_tag_assignments_on_entry_id"
  add_index "tag_assignments", ["tag_id"], :name => "index_tag_assignments_on_tag_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "text_formats", :force => true do |t|
    t.string   "name"
    t.string   "class_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "name"
    t.string   "email_address"
    t.boolean  "administrator",                           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state",                                   :default => "active"
    t.datetime "key_timestamp"
  end

  add_index "users", ["state"], :name => "index_users_on_state"

end
