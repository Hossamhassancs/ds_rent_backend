# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_07_13_051804) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "brands", force: :cascade do |t|
    t.string "name_ar"
    t.string "name_en"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cars", force: :cascade do |t|
    t.string "name_en"
    t.string "name_ar"
    t.integer "seats_num"
    t.integer "make_year"
    t.float "engine_size"
    t.string "transmission_ar"
    t.string "transmission_en"
    t.integer "cylinders"
    t.string "fuel_type_en"
    t.string "fuel_type_ar"
    t.integer "doors"
    t.string "colors"
    t.string "car_type_ar"
    t.string "car_type_en"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "brand_id", null: false
    t.string "features", default: [], array: true
    t.decimal "price"
    t.boolean "in_stock"
    t.index ["brand_id"], name: "index_cars_on_brand_id"
  end

  create_table "images", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_images_on_car_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.string "customer_name"
    t.string "email"
    t.string "phone"
    t.string "pickup_location"
    t.string "dropoff_location"
    t.string "trip_type"
    t.datetime "time"
    t.datetime "dropoff_time"
    t.bigint "car_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "pending"
    t.string "pickup_location_address"
    t.float "pickup_location_latitude"
    t.float "pickup_location_longitude"
    t.string "pickup_location_city"
    t.string "pickup_location_country"
    t.float "duration_in_hours"
    t.index ["car_id"], name: "index_reservations_on_car_id"
  end

  add_foreign_key "cars", "brands"
  add_foreign_key "images", "cars"
  add_foreign_key "reservations", "cars"
end
