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

ActiveRecord::Schema.define(version: 20161112025606) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "featured_properties", force: :cascade do |t|
    t.datetime "end_at"
    t.datetime "start_at"
    t.string   "notes"
    t.datetime "published_at"
    t.integer  "property_container_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["property_container_id"], name: "index_featured_properties_on_property_container_id", using: :btree
  end

  create_table "property_containers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "featured_properties", "property_containers"
end
