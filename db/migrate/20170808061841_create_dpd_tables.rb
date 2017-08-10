class CreateDpdTables < ActiveRecord::Migration
  def change

    create_table :dpd_service_infos do |t|
      t.string 'code'      , limit:   3
      t.string 'field_info', limit: 255

      t.timestamps
    end

    create_table :dpd_countries do |t|
      t.string 'iso_country_code'        , limit:  3
      t.string 'iso_alpha_2_country_code', limit:  2
      t.string 'iso_alpha_3_country_code', limit:  3
      t.string 'destination_language'    , limit: 45
      t.boolean 'flag_post_code_no'

      t.timestamps
    end

    create_table :dpd_depots do |t|
      t.string 'number'                  , limit:   4
      t.string 'i_ata_like_code'         , limit:   3
      t.string 'group_id'                , limit:   4
      t.string 'name1'                   , limit: 255
      t.string 'name2'                   , limit: 255
      t.string 'address1'                , limit: 255
      t.string 'address2'                , limit: 255
      t.string 'post_code'               , limit:  45
      t.string 'city_name'               , limit: 255
      t.string 'iso_alpha_2_country_code', limit:   2
      t.string 'phone'                   , limit: 255
      t.string 'fax'                     , limit: 255
      t.string 'mail'                    , limit: 255
      t.string 'web'                     , limit: 255

      t.timestamps
    end

    create_table :dpd_services do |t|
      t.string 'code'    , limit:  3
      t.string 'text'    , limit: 45
      t.string 'mark'    , limit:  1
      t.string 'elements', limit: 45

      t.timestamps
    end


    create_table :dpd_locations do |t|
      t.string 'area_name'               , limit:  10
      t.string 'city_name'               , limit: 255
      t.string 'iso_alpha_2_country_code', limit:   5
      t.string 'post_code'               , limit:  45

      t.timestamps
    end

    create_table :dpd_routes do |t|
      t.string  'destination_country', limit:   2
      t.string  'begin_post_code'    , limit:   7
      t.string  'end_post_code'      , limit:   7
      t.string  'service_codes'      , limit: 255
      t.text    'routing_places'
      t.date    'sending_date'
      t.string  'o_sort'           , limit: 4
      t.string  'd_depot'          , limit: 4
      t.string  'grouping_priority', limit: 1
      t.string  'd_sort'           , limit: 4
      t.integer 'barcode_id'       , limit: 6
      t.date    'expiration_date'

      t.timestamps
    end

    add_index :dpd_routes, [:destination_country, :begin_post_code, :end_post_code], name: 'country_zip_code_idx'

  end
end
