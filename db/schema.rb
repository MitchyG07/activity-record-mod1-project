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

ActiveRecord::Schema.define(version: 2020_12_07_214840) do

  create_table "activities", force: :cascade do |t|
    t.string "activity"
    t.integer "nationalpark_id"
    t.integer "tourist_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "date"
  end

  create_table "nationalparks", force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.text "description"
    t.string "location"
    t.string "designation"
    t.text "weather"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "states"
  end

  create_table "tourists", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
  end

end
