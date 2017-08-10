class CreateParcel < ActiveRecord::Migration
  def change
    create_table "parcels", force: :cascade do |t|
      t.integer  "shipment_id",       limit: 4
      t.integer  "parcel_no",         limit: 4, default: 1
      t.string   "tracking_no",       limit: 35
      t.decimal  "weight",            precision: 5, scale: 2, default: 0.0
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
