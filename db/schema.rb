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

ActiveRecord::Schema.define(version: 20141226094405) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "api_keys", force: true do |t|
    t.string  "name"
    t.string  "access_token"
    t.boolean "active"
  end

  create_table "artisans", force: true do |t|
    t.string   "name"
    t.integer  "tasks_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artisans", ["tasks_id"], name: "index_artisans_on_tasks_id", using: :btree

  create_table "artisans_tasks", id: false, force: true do |t|
    t.integer "artisan_id"
    t.integer "task_id"
  end

  create_table "attachments", force: true do |t|
    t.string   "document"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "blog_articles", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "image"
    t.string   "locale"
    t.boolean  "published"
    t.date     "publish_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_projects", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "image"
    t.string   "locale"
    t.boolean  "published"
    t.date     "publish_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_videos", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "video_url"
    t.string   "locale"
    t.boolean  "published"
    t.date     "publish_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certificates", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certificates_inventories", force: true do |t|
    t.integer "certificate_id"
    t.integer "inventory_id"
  end

  create_table "certificates_locations", force: true do |t|
    t.integer "certificate_id"
    t.integer "location_id"
  end

  create_table "certificates_users", force: true do |t|
    t.integer "certificate_id"
    t.integer "user_id"
  end

  create_table "changes", force: true do |t|
    t.text     "description"
    t.integer  "hours_spent_id"
    t.integer  "changed_by_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "runs_in_company_car"
    t.float    "km_driven_own_car"
    t.float    "toll_expenses_own_car"
    t.string   "supplies_from_warehouse"
    t.integer  "piecework_hours"
    t.integer  "overtime_50"
    t.integer  "overtime_100"
    t.integer  "hour"
    t.string   "text"
    t.text     "reason"
  end

  create_table "comfy_cms_blocks", force: true do |t|
    t.string   "identifier",     null: false
    t.text     "content"
    t.integer  "blockable_id"
    t.string   "blockable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_blocks", ["blockable_id", "blockable_type"], name: "index_comfy_cms_blocks_on_blockable_id_and_blockable_type", using: :btree
  add_index "comfy_cms_blocks", ["identifier"], name: "index_comfy_cms_blocks_on_identifier", using: :btree

  create_table "comfy_cms_categories", force: true do |t|
    t.integer "site_id",          null: false
    t.string  "label",            null: false
    t.string  "categorized_type", null: false
  end

  add_index "comfy_cms_categories", ["site_id", "categorized_type", "label"], name: "index_cms_categories_on_site_id_and_cat_type_and_label", unique: true, using: :btree

  create_table "comfy_cms_categorizations", force: true do |t|
    t.integer "category_id",      null: false
    t.string  "categorized_type", null: false
    t.integer "categorized_id",   null: false
  end

  add_index "comfy_cms_categorizations", ["category_id", "categorized_type", "categorized_id"], name: "index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id", unique: true, using: :btree

  create_table "comfy_cms_files", force: true do |t|
    t.integer  "site_id",                                    null: false
    t.integer  "block_id"
    t.string   "label",                                      null: false
    t.string   "file_file_name",                             null: false
    t.string   "file_content_type",                          null: false
    t.integer  "file_file_size",                             null: false
    t.string   "description",       limit: 2048
    t.integer  "position",                       default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_files", ["site_id", "block_id"], name: "index_comfy_cms_files_on_site_id_and_block_id", using: :btree
  add_index "comfy_cms_files", ["site_id", "file_file_name"], name: "index_comfy_cms_files_on_site_id_and_file_file_name", using: :btree
  add_index "comfy_cms_files", ["site_id", "label"], name: "index_comfy_cms_files_on_site_id_and_label", using: :btree
  add_index "comfy_cms_files", ["site_id", "position"], name: "index_comfy_cms_files_on_site_id_and_position", using: :btree

  create_table "comfy_cms_layouts", force: true do |t|
    t.integer  "site_id",                    null: false
    t.integer  "parent_id"
    t.string   "app_layout"
    t.string   "label",                      null: false
    t.string   "identifier",                 null: false
    t.text     "content"
    t.text     "css"
    t.text     "js"
    t.integer  "position",   default: 0,     null: false
    t.boolean  "is_shared",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_layouts", ["parent_id", "position"], name: "index_comfy_cms_layouts_on_parent_id_and_position", using: :btree
  add_index "comfy_cms_layouts", ["site_id", "identifier"], name: "index_comfy_cms_layouts_on_site_id_and_identifier", unique: true, using: :btree

  create_table "comfy_cms_pages", force: true do |t|
    t.integer  "site_id",                        null: false
    t.integer  "layout_id"
    t.integer  "parent_id"
    t.integer  "target_page_id"
    t.string   "label",                          null: false
    t.string   "slug"
    t.string   "full_path",                      null: false
    t.text     "content_cache"
    t.integer  "position",       default: 0,     null: false
    t.integer  "children_count", default: 0,     null: false
    t.boolean  "is_published",   default: true,  null: false
    t.boolean  "is_shared",      default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_pages", ["parent_id", "position"], name: "index_comfy_cms_pages_on_parent_id_and_position", using: :btree
  add_index "comfy_cms_pages", ["site_id", "full_path"], name: "index_comfy_cms_pages_on_site_id_and_full_path", using: :btree

  create_table "comfy_cms_revisions", force: true do |t|
    t.string   "record_type", null: false
    t.integer  "record_id",   null: false
    t.text     "data"
    t.datetime "created_at"
  end

  add_index "comfy_cms_revisions", ["record_type", "record_id", "created_at"], name: "index_cms_revisions_on_rtype_and_rid_and_created_at", using: :btree

  create_table "comfy_cms_sites", force: true do |t|
    t.string  "label",                       null: false
    t.string  "identifier",                  null: false
    t.string  "hostname",                    null: false
    t.string  "path"
    t.string  "locale",      default: "en",  null: false
    t.boolean "is_mirrored", default: false, null: false
  end

  add_index "comfy_cms_sites", ["hostname"], name: "index_comfy_cms_sites_on_hostname", using: :btree
  add_index "comfy_cms_sites", ["is_mirrored"], name: "index_comfy_cms_sites_on_is_mirrored", using: :btree

  create_table "comfy_cms_snippets", force: true do |t|
    t.integer  "site_id",                    null: false
    t.string   "label",                      null: false
    t.string   "identifier",                 null: false
    t.text     "content"
    t.integer  "position",   default: 0,     null: false
    t.boolean  "is_shared",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_snippets", ["site_id", "identifier"], name: "index_comfy_cms_snippets_on_site_id_and_identifier", unique: true, using: :btree
  add_index "comfy_cms_snippets", ["site_id", "position"], name: "index_comfy_cms_snippets_on_site_id_and_position", using: :btree

  create_table "customer_messages", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "org_number"
    t.string   "contact_person"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_nr"
    t.string   "area"
    t.string   "email"
  end

  create_table "departments", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", force: true do |t|
    t.integer  "user_id"
    t.integer  "favorable_id"
    t.string   "favorable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hours_spents", force: true do |t|
    t.integer  "customer_id"
    t.integer  "task_id"
    t.integer  "hour"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "piecework_hours"
    t.integer  "overtime_50"
    t.integer  "overtime_100"
    t.integer  "project_id"
    t.integer  "runs_in_company_car"
    t.float    "km_driven_own_car"
    t.float    "toll_expenses_own_car"
    t.string   "supplies_from_warehouse"
  end

  add_index "hours_spents", ["customer_id"], name: "index_hours_spents_on_customer_id", using: :btree
  add_index "hours_spents", ["task_id"], name: "index_hours_spents_on_task_id", using: :btree

  create_table "inventories", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "certificates_id"
    t.boolean  "can_be_rented_by_other_companies", default: false
    t.integer  "rental_price_pr_day"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inventories", ["certificates_id"], name: "index_inventories_on_certificates_id", using: :btree

  create_table "inventories_tasks", force: true do |t|
    t.integer "inventory_id"
    t.integer "task_id"
  end

  create_table "locations", force: true do |t|
    t.string   "name"
    t.integer  "certificates_id"
    t.boolean  "outdoor"
    t.boolean  "indoor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "professions", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "project_number"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_id"
    t.date     "start_date"
    t.date     "due_date"
    t.text     "description"
    t.integer  "user_id"
    t.string   "execution_address"
    t.text     "customer_reference"
    t.text     "comment"
    t.boolean  "sms_employee_if_hours_not_registered", default: false
    t.boolean  "sms_employee_when_new_task_created",   default: false
    t.integer  "department_id"
    t.string   "short_description"
    t.boolean  "complete",                             default: false
  end

  create_table "task_types", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.integer  "customer_id"
    t.date     "start_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "accepted"
    t.string   "description"
    t.boolean  "finished",         default: false
    t.integer  "project_id"
    t.date     "due_date"
    t.datetime "ended_at"
    t.integer  "work_category_id"
    t.integer  "location_id"
  end

  add_index "tasks", ["customer_id"], name: "index_tasks_on_customer_id", using: :btree

  create_table "tinymce_assets", force: true do |t|
    t.string   "image"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_tasks", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "task_id",    null: false
    t.string   "status",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "encrypted_password",                           null: false
    t.string   "roles",                                                     array: true
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "department_id"
    t.integer  "mobile",                 limit: 8
    t.string   "employee_nr"
    t.string   "image"
    t.string   "emp_id"
    t.integer  "profession_id"
    t.string   "home_address"
    t.string   "home_area_code"
    t.string   "home_area"
  end

  add_index "users", ["profession_id"], name: "index_users_on_profession_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "zipped_reports", force: true do |t|
    t.integer  "project_id",  null: false
    t.string   "zipfile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "report_type"
  end

end
