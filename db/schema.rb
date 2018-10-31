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

ActiveRecord::Schema.define(version: 0) do

  create_table "accessPlainText", primary_key: "ID", id: :integer, unsigned: true, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.text "name"
  end

  create_table "accessTypes", primary_key: "ID", id: :integer, unsigned: true, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
  end

  create_table "databases_curated", primary_key: "ID", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "dbID", null: false, unsigned: true
    t.integer "subjectID", null: false, unsigned: true
    t.integer "sort", default: 0, unsigned: true
  end

  create_table "databases_resourceTypes", primary_key: "ID", id: :integer, unsigned: true, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "dbID", unsigned: true
    t.integer "resourceID", unsigned: true
  end

  create_table "databases_subjects", primary_key: "ID", id: :integer, unsigned: true, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "dbID", null: false, unsigned: true
    t.integer "subjectID", null: false, unsigned: true
  end

  create_table "dbList", primary_key: "ID", id: :integer, unsigned: true, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.integer "status", unsigned: true
    t.string "yearsOfCoverage", limit: 50
    t.integer "vendor", limit: 2, unsigned: true
    t.string "url"
    t.string "offCampusURL"
    t.string "updated", limit: 100
    t.integer "accessType", limit: 1, unsigned: true
    t.integer "fullTextDB", limit: 1, default: 0, null: false, unsigned: true
    t.integer "newDatabase", limit: 1, default: 0, null: false, unsigned: true
    t.integer "trialDatabase", limit: 1, default: 0, null: false, unsigned: true
    t.integer "access", unsigned: true
    t.text "help"
    t.text "helpURL"
    t.text "description"
    t.integer "createDate", unsigned: true
    t.integer "updateDate", unsigned: true
    t.string "URLID", limit: 50
    t.integer "popular", limit: 1, default: 0, null: false, unsigned: true
    t.integer "trialExpireDate"
    t.integer "alumni", limit: 1, default: 0, null: false, unsigned: true
    t.boolean "mobile", default: false, unsigned: true
    t.string "titleSearch"
  end

  create_table "dbStats", primary_key: "ID", id: :integer, unsigned: true, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "dbID", unsigned: true
    t.integer "location", limit: 1, unsigned: true
    t.integer "accessDate", unsigned: true
    t.string "referrer"
    t.string "ipaddress", limit: 15
  end

  create_table "dbStatus", primary_key: "ID", id: :integer, limit: 1, unsigned: true, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
  end

  create_table "ipLocations", primary_key: "ID", id: :integer, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "ipRange", limit: 75
    t.string "name", limit: 50
  end

  create_table "news", primary_key: "ID", id: :integer, unsigned: true, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
  end

  create_table "resourceTypes", primary_key: "ID", id: :integer, unsigned: true, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
  end

  create_table "subjects", primary_key: "ID", id: :integer, unsigned: true, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", limit: 50
    t.string "url"
  end

  create_table "updateText", primary_key: "ID", id: :integer, unsigned: true, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
  end

  create_table "vendors", primary_key: "ID", id: :integer, unsigned: true, options: "ENGINE=MyISAM DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name", limit: 50
    t.string "url"
  end

end
