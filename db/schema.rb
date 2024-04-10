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

ActiveRecord::Schema.define(version: 2024_04_10_171224) do

  create_table "access_plain_text", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "name", limit: 16777215
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "access_types", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "database_list", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.integer "status", unsigned: true
    t.string "years_of_coverage", limit: 50
    t.integer "vendor_id", unsigned: true
    t.string "url"
    t.string "off_campus_url"
    t.string "updated", limit: 100
    t.integer "access_type_id", limit: 1, unsigned: true
    t.boolean "full_text_db", default: false, null: false
    t.boolean "new_database", default: false, null: false
    t.boolean "trial_database", default: false, null: false
    t.integer "access_plain_text_id", unsigned: true
    t.text "help", limit: 16777215
    t.text "help_url", limit: 16777215
    t.text "description", limit: 16777215
    t.integer "created_date", unsigned: true
    t.integer "updated_date", unsigned: true
    t.string "url_uuid", limit: 50
    t.boolean "popular", default: false, null: false
    t.integer "trial_expire_date"
    t.boolean "alumni", default: false, null: false
    t.boolean "mobile", default: false, unsigned: true
    t.string "title_search"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "trial_expiration_date"
    t.integer "access", default: 2
    t.integer "libguides_id"
    t.boolean "disable_proxy", default: false
    t.boolean "open_access", default: false
    t.index ["libguides_id"], name: "index_database_list_on_libguides_id", unique: true
    t.index ["url_uuid"], name: "index_database_list_on_url_uuid", unique: true
    t.index ["vendor_id"], name: "fk_vendor_id"
  end

  create_table "database_status", id: :integer, limit: 1, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "databases_curated", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "database_id", null: false, unsigned: true
    t.integer "subject_id", null: false, unsigned: true
    t.integer "sort", default: 0, unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "databases_resource_types", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "database_id", unsigned: true
    t.integer "resource_id", unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "databases_subjects", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "database_id", null: false, unsigned: true
    t.integer "subject_id", null: false, unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ip_locations", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "ip_range", limit: 75
    t.string "name", limit: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "landing_pages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.text "instructions"
    t.text "restrictions"
    t.text "html_links"
    t.string "contact_name"
    t.string "contact_title"
    t.string "contact_email"
    t.string "contact_phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "database_id"
    t.index ["database_id"], name: "index_landing_pages_on_database_id"
  end

  create_table "link_trackings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "database_type"
    t.bigint "database_id"
    t.string "ip_address", limit: 15
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["database_type", "database_id"], name: "index_link_trackings_on_database_type_and_database_id"
  end

  create_table "news", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resource_types", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "statistics", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "dbID", unsigned: true
    t.integer "location", limit: 1, unsigned: true
    t.integer "access_date", unsigned: true
    t.string "referrer"
    t.string "ip_address", limit: 15
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subjects", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", limit: 50
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "update_text", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "cas_email"
    t.string "cas_username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vendors", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci", force: :cascade do |t|
    t.string "name", limit: 50
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "database_list", "vendors", name: "fk_vendor_id"
end
