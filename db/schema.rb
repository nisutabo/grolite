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

ActiveRecord::Schema.define(version: 2018_04_04_223920) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crops", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "scientific_name"
    t.string "crop_group"
    t.integer "temp_day"
    t.integer "temp_night"
    t.integer "humidity"
    t.integer "ph"
    t.integer "ec"
    t.integer "dli"
    t.integer "sun_hours"
    t.integer "dth"
  end

  create_table "groups", force: :cascade do |t|
    t.datetime "seed_date"
    t.datetime "harvest_date"
    t.integer "germination_days"
    t.integer "propagation_days"
    t.integer "production_days"
    t.integer "expected_harvest_lbs"
    t.integer "actual_harvest_lbs"
    t.boolean "harvested"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "crop_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "group_id"
    t.integer "crop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

end
