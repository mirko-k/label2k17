class CreateCountries < ActiveRecord::Migration
  def change
    create_table "countries", force: :cascade do |t|
      t.string   "name",                             limit: 35
      t.string   "alpha2_code",                      limit: 2
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
