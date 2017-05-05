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

ActiveRecord::Schema.define(version: 20170504220015) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "name"
    t.string   "sport"
    t.datetime "activity_id"
    t.string   "gpx_file_name"
    t.string   "gpx_content_type"
    t.integer  "gpx_file_size"
    t.datetime "gpx_updated_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "lap_summaries", force: :cascade do |t|
    t.integer  "lap_id"
    t.float    "total_time_seconds"
    t.float    "distance_meters"
    t.float    "maximum_speed"
    t.float    "calories"
    t.integer  "average_heart_rate_bmp"
    t.integer  "maximum_heart_rate_bmp"
    t.string   "intensity"
    t.integer  "cadence"
    t.string   "trigger_method"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["lap_id"], name: "index_lap_summaries_on_lap_id", using: :btree
  end

  create_table "laps", force: :cascade do |t|
    t.datetime "start_time"
    t.integer  "activity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["activity_id"], name: "index_laps_on_activity_id", using: :btree
  end

  add_foreign_key "lap_summaries", "laps"
  add_foreign_key "laps", "activities"
end
