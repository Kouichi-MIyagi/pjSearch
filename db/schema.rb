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

ActiveRecord::Schema.define(:version => 20131205023247) do
>>>>>>> a53941195442035299813cafb9a47dd5fa66d853

  create_table "customers", :force => true do |t|
    t.string   "csname"
    t.string   "cscode"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questionitems", :force => true do |t|
    t.string   "question"
    t.integer  "selectionNumber"
    t.string   "questionItem"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "questionnaires", :force => true do |t|
    t.string   "title"
    t.date     "effectiveFrom"
    t.date     "effectiveTo"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "request_questionnaires", :force => true do |t|
    t.integer  "user_id"
    t.integer  "questionnaire_id"
    t.integer  "target_year"
    t.integer  "target_month"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "response_items", :force => true do |t|
    t.integer  "response_id"
    t.string   "question"
    t.integer  "selectionNumber"
    t.string   "selectionItem"
    t.string   "Comment"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "responses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "customer_id"
    t.string   "pjName"
    t.integer  "targetYear"
    t.integer  "targetMonth"
    t.string   "comment"
    t.string   "attachedFile"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "user_id"
    t.string   "user_name"
    t.integer  "customer_id"
    t.string   "user_access"
    t.string   "recent_project"
    t.string   "recent_customer"
    t.string   "recent_resident"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
