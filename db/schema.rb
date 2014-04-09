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

ActiveRecord::Schema.define(version: 20140409133201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artisans", force: true do |t|
    t.string   "name"
    t.integer  "tasks_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artisans", ["tasks_id"], name: "index_artisans_on_tasks_id", using: :btree

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "org_number"
    t.string   "contact_person"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hours_spents", force: true do |t|
    t.integer  "customer_id"
    t.integer  "task_id"
    t.integer  "hour"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hours_spents", ["customer_id"], name: "index_hours_spents_on_customer_id", using: :btree
  add_index "hours_spents", ["task_id"], name: "index_hours_spents_on_task_id", using: :btree

  create_table "paints", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_types", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.integer  "customer_id"
    t.integer  "task_type_id"
    t.datetime "start_date"
    t.boolean  "customer_buys_supplies"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "paint_id"
    t.integer  "artisan_id"
    t.boolean  "accepted"
    t.string   "description"
    t.boolean  "finished",               default: false
  end

  add_index "tasks", ["customer_id"], name: "index_tasks_on_customer_id", using: :btree
  add_index "tasks", ["task_type_id"], name: "index_tasks_on_task_type_id", using: :btree

end
