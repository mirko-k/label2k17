class CreateAddresses < ActiveRecord::Migration
  def change
    create_table "addresses", force: :cascade do |t|
      t.string   "company_name",    limit: 35
      t.string   "name_1",          limit: 35
      t.string   "name_2",          limit: 35
      t.string   "additions",       limit: 35
      t.string   "street",          limit: 43
      t.string   "city",            limit: 35
      t.string   "zip_code",        limit: 9
      t.string   "telephone",       limit: 30
      t.integer  "country_id",      limit: 4
      t.datetime "created_at"
      t.datetime "updated_at"
    end
    add_index "addresses", ["company_name", "street", "name_1", "name_2", "city", "zip_code", "country_id"], name: "combined_address_idx", using: :btree
  end
end
