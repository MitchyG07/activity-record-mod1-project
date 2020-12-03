# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_03_001615) do

  create_table "nationalparks", force: :cascade do |t|
    t.string "name"
    t.string "state"
    t.text "activities"
    t.integer "contact"
    t.float "fee"
    t.string "address"
    t.string "weather"
    t.text "campground"
    t.float "latitude"
    t.float "longitude"
    t.text "description"
  end

  create_table "permits", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "nationalpark_id"
    t.integer "tourist_id"
  end

  create_table "tourists", force: :cascade do |t|
    t.string "name"
  end

end
