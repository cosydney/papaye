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

ActiveRecord::Schema.define(version: 20160822145205) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company"
    t.string   "company_number"
    t.string   "address"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "email"
  end

  add_index "clients", ["user_id"], name: "index_clients_on_user_id", using: :btree

  create_table "descriptions", force: :cascade do |t|
    t.integer  "invoice_id"
    t.text     "description"
    t.string   "unit"
    t.float    "price"
    t.float    "amount"
    t.float    "vat_tax"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "descriptions", ["invoice_id"], name: "index_descriptions_on_invoice_id", using: :btree

  create_table "freelancers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "company_name"
    t.text     "address"
    t.text     "company_nr"
    t.integer  "vat"
    t.string   "iban"
    t.integer  "bank_nr"
    t.integer  "branch_nr"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "email_text"
  end

  add_index "freelancers", ["user_id"], name: "index_freelancers_on_user_id", using: :btree

  create_table "invoice_transitions", force: :cascade do |t|
    t.string   "to_state",                   null: false
    t.text     "metadata",    default: "{}"
    t.integer  "sort_key",                   null: false
    t.integer  "invoice_id",                 null: false
    t.boolean  "most_recent",                null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "invoice_transitions", ["invoice_id", "most_recent"], name: "index_invoice_transitions_parent_most_recent", unique: true, where: "most_recent", using: :btree
  add_index "invoice_transitions", ["invoice_id", "sort_key"], name: "index_invoice_transitions_parent_sort", unique: true, using: :btree

  create_table "invoices", force: :cascade do |t|
    t.integer  "freelancer_id"
    t.integer  "client_id"
    t.date     "invoice_date"
    t.date     "due_date"
    t.integer  "invoice_nr"
    t.string   "invoice_terms"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "email"
    t.datetime "email_sent_at"
  end

  add_index "invoices", ["client_id"], name: "index_invoices_on_client_id", using: :btree
  add_index "invoices", ["freelancer_id"], name: "index_invoices_on_freelancer_id", using: :btree

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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "clients", "users"
  add_foreign_key "descriptions", "invoices"
  add_foreign_key "freelancers", "users"
  add_foreign_key "invoices", "clients"
  add_foreign_key "invoices", "freelancers"
end
