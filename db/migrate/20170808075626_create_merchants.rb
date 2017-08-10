class CreateMerchants < ActiveRecord::Migration
  def change
    create_table "merchants", force: :cascade do |t|
      t.string   "name",                             limit: 35
      t.integer  "address_id",                       limit: 4
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
