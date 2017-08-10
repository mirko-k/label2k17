class CreateShipments < ActiveRecord::Migration
  def change
    create_table "shipments", force: :cascade do |t|
      t.integer  "address_id",        limit: 4
      t.integer  "hauler_id",         limit: 4
      t.integer  "merchant_id",       limit: 4
      t.integer  "parcel_count",      limit: 4, default: 1
      t.decimal  "cod_amount",        precision: 7, scale: 2, default: 0.0
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
