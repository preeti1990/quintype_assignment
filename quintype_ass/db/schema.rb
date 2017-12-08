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

ActiveRecord::Schema.define(version: 20171208095155) do

  create_table "cab_driver_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "phone"
    t.string   "otp"
    t.float    "avg_user_rating",     limit: 24
    t.string   "experience"
    t.string   "driving_liscence_no"
    t.string   "aadhar_no"
    t.boolean  "verified"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "name"
  end

  create_table "cab_facilities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "cab_id"
    t.integer  "facility_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["cab_id"], name: "index_cab_facilities_on_cab_id", using: :btree
    t.index ["facility_id"], name: "index_cab_facilities_on_facility_id", using: :btree
  end

  create_table "cabs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "classie_no"
    t.string   "reg_no"
    t.string   "insurance_no"
    t.string   "model"
    t.string   "no_of_seats"
    t.string   "owner_name"
    t.string   "owner_address"
    t.datetime "reg_date"
    t.string   "wheels"
    t.string   "color"
    t.boolean  "active"
    t.string   "fuel"
    t.string   "permit_type"
    t.string   "vehicle_type"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.integer  "service_type_id"
    t.integer  "cab_driver_id"
    t.integer  "cab_driver_profile_id"
    t.index ["cab_driver_id"], name: "index_cabs_on_cab_driver_id", using: :btree
    t.index ["cab_driver_profile_id"], name: "index_cabs_on_cab_driver_profile_id", using: :btree
    t.index ["service_type_id"], name: "index_cabs_on_service_type_id", using: :btree
  end

  create_table "facilities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "known_languages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "cab_driver_profile_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["cab_driver_profile_id"], name: "index_known_languages_on_cab_driver_profile_id", using: :btree
  end

  create_table "locations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.float    "lat",            limit: 24
    t.float    "lng",            limit: 24
    t.string   "street_address"
    t.string   "sublocality"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "country"
    t.string   "landmark"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "owner_type"
    t.integer  "owner_id"
    t.index ["owner_type", "owner_id"], name: "index_locations_on_owner_type_and_owner_id", using: :btree
  end

  create_table "media", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "owner_type"
    t.integer  "owner_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["owner_type", "owner_id"], name: "index_media_on_owner_type_and_owner_id", using: :btree
  end

  create_table "ratings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "ride_id"
    t.float    "star_rating", limit: 24
    t.string   "comment"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["ride_id"], name: "index_ratings_on_ride_id", using: :btree
    t.index ["user_id"], name: "index_ratings_on_user_id", using: :btree
  end

  create_table "rides", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.datetime "ride_time"
    t.float    "amount",                  limit: 24
    t.boolean  "amount_paid"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "source_location_id"
    t.integer  "destination_location_id"
    t.string   "ride_state"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.integer  "user_id"
    t.float    "altered_price",           limit: 24
    t.integer  "seat_id"
    t.string   "otp"
    t.index ["seat_id"], name: "index_rides_on_seat_id", using: :btree
    t.index ["user_id"], name: "index_rides_on_user_id", using: :btree
  end

  create_table "seats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "bookable"
    t.integer  "cab_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cab_id"], name: "index_seats_on_cab_id", using: :btree
  end

  create_table "service_types", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.float    "price",      limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  add_foreign_key "cab_facilities", "cabs"
  add_foreign_key "cab_facilities", "facilities"
  add_foreign_key "cabs", "cab_driver_profiles"
  add_foreign_key "cabs", "service_types"
  add_foreign_key "known_languages", "cab_driver_profiles"
  add_foreign_key "ratings", "rides"
  add_foreign_key "ratings", "users"
  add_foreign_key "rides", "seats"
  add_foreign_key "rides", "users"
  add_foreign_key "seats", "cabs"
end
