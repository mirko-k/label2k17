class CreateHaulers < ActiveRecord::Migration
  def change
    create_table "haulers", force: :cascade do |t|
      t.string   "name",                             limit: 35
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
