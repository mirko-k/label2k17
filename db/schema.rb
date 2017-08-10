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

ActiveRecord::Schema.define(version: 20170808084927) do

  create_table "addresses", force: :cascade do |t|
    t.string   "company_name", limit: 35
    t.string   "name_1",       limit: 35
    t.string   "name_2",       limit: 35
    t.string   "additions",    limit: 35
    t.string   "street",       limit: 43
    t.string   "city",         limit: 35
    t.string   "zip_code",     limit: 9
    t.string   "telephone",    limit: 30
    t.integer  "country_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "addresses", ["company_name", "street", "name_1", "name_2", "city", "zip_code", "country_id"], name: "combined_address_idx", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name",        limit: 35
    t.string   "alpha2_code", limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dpd_countries", force: :cascade do |t|
    t.string   "iso_country_code",         limit: 3
    t.string   "iso_alpha_2_country_code", limit: 2
    t.string   "iso_alpha_3_country_code", limit: 3
    t.string   "destination_language",     limit: 45
    t.boolean  "flag_post_code_no",        limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dpd_depots", force: :cascade do |t|
    t.string   "number",                   limit: 4
    t.string   "i_ata_like_code",          limit: 3
    t.string   "group_id",                 limit: 4
    t.string   "name1",                    limit: 255
    t.string   "name2",                    limit: 255
    t.string   "address1",                 limit: 255
    t.string   "address2",                 limit: 255
    t.string   "post_code",                limit: 45
    t.string   "city_name",                limit: 255
    t.string   "iso_alpha_2_country_code", limit: 2
    t.string   "phone",                    limit: 255
    t.string   "fax",                      limit: 255
    t.string   "mail",                     limit: 255
    t.string   "web",                      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dpd_locations", force: :cascade do |t|
    t.string   "area_name",                limit: 10
    t.string   "city_name",                limit: 255
    t.string   "iso_alpha_2_country_code", limit: 5
    t.string   "post_code",                limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dpd_routes", force: :cascade do |t|
    t.string   "destination_country", limit: 2
    t.string   "begin_post_code",     limit: 7
    t.string   "end_post_code",       limit: 7
    t.string   "service_codes",       limit: 255
    t.text     "routing_places",      limit: 65535
    t.date     "sending_date"
    t.string   "o_sort",              limit: 4
    t.string   "d_depot",             limit: 4
    t.string   "grouping_priority",   limit: 1
    t.string   "d_sort",              limit: 4
    t.integer  "barcode_id",          limit: 8
    t.date     "expiration_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dpd_routes", ["destination_country", "begin_post_code", "end_post_code"], name: "country_zip_code_idx", using: :btree

  create_table "dpd_service_infos", force: :cascade do |t|
    t.string   "code",       limit: 3
    t.string   "field_info", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dpd_services", force: :cascade do |t|
    t.string   "code",       limit: 3
    t.string   "text",       limit: 45
    t.string   "mark",       limit: 1
    t.string   "elements",   limit: 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "haulers", force: :cascade do |t|
    t.string   "name",       limit: 35
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merchants", force: :cascade do |t|
    t.string   "name",       limit: 35
    t.integer  "address_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parcels", force: :cascade do |t|
    t.integer  "shipment_id", limit: 4
    t.integer  "parcel_no",   limit: 4,                          default: 1
    t.string   "tracking_no", limit: 35
    t.decimal  "weight",                 precision: 5, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shipments", force: :cascade do |t|
    t.integer  "address_id",   limit: 4
    t.integer  "hauler_id",    limit: 4
    t.integer  "merchant_id",  limit: 4
    t.integer  "parcel_count", limit: 4,                         default: 1
    t.decimal  "cod_amount",             precision: 7, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
