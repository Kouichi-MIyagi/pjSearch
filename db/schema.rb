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

ActiveRecord::Schema.define(:version => 20131216012823) do

  create_table "customers", :force => true do |t|
    t.string   "csname"
    t.string   "cscode"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questionitems", :force => true do |t|
    t.string   "question"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "answer1"
    t.string   "answer1_item"
    t.integer  "answer2"
    t.string   "answer2_item"
    t.integer  "answer3"
    t.string   "answer3_item"
    t.integer  "answer4"
    t.string   "answer4_item"
  end

  create_table "questionitems_questionnaires", :id => false, :force => true do |t|
    t.integer "questionitem_id"
    t.integer "questionnaire_id"
  end

  create_table "questionnaires", :force => true do |t|
    t.string   "title"
    t.date     "effectiveFrom"
    t.date     "effectiveTo"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "request_questionnaires", :force => true do |t|
    t.integer  "questionnaire_id"
    t.integer  "target_year"
    t.integer  "target_month"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "mail_tilte"
    t.text     "mail_banner"
    t.text     "mail_content"
    t.text     "mail_trailer"
    t.date     "day_of_mail_sent"
    t.string   "resident"
    t.string   "transfferred"
  end

  create_table "response_items", :force => true do |t|
    t.integer  "response_id"
    t.string   "question"
    t.integer  "selection_number"
    t.string   "selection_item"
    t.string   "comment"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "responses", :force => true do |t|
    t.integer  "user_id"
    t.integer  "customer_id"
    t.string   "pjName"
    t.integer  "targetYear"
    t.integer  "targetMonth"
    t.string   "comment"
    t.string   "attachedFile"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.integer  "request_questionnaire_id"
  end

  create_table "topics", :force => true do |t|
    t.string   "contents"
    t.date     "effective_to"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                    :default => "", :null => false
    t.string   "encrypted_password",       :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "user_name"
    t.integer  "customer_id"
    t.string   "user_access"
    t.string   "recent_project"
    t.string   "recent_customer"
    t.string   "recent_resident"
    t.string   "user_id"
    t.boolean  "resident"
    t.boolean  "transfferred"
    t.integer  "request_questionnaire_id"
    t.string   "role"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
