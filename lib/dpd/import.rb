module Dpd
  class Import
    require 'zip'
    attr_reader :file_path

    def initialize( file_path )
      return false unless File.exists?( file_path )
      @file_path = file_path
    end

    def write_routing_table
      Zip::File.open(@file_path) do |zipfile|
        zipfile.each do |file|
          data = zipfile.read(file.name)
          parse_file file.name, data
        end
      end
    end

    private

    def parse_file(filename, data)
      ActiveRecord::Base.transaction do
        case filename
        when 'SERVICEINFO.DE'
          Dpd::ServiceInfo.truncate!
          data.lines.select { |line| line[0] != '#' }.each do |line|
            attr = line.split('|')
            ::Dpd::ServiceInfo.create code: attr[0], field_info: attr[1]
          end

        when 'COUNTRY'
          Dpd::Country.truncate!
          data.lines.select { |line| line[0] != '#' }.each do |line|
            parse_country line.split('|')
          end

        when 'DEPOTS'
          ::Dpd::Depot.truncate!
          data.lines.select { |line| line[0] != '#' }.each do |line|
            parse_depot line.split('|')
          end

        when 'SERVICE'
          ::Dpd::Service.truncate!
          data.lines.select { |line| line[0] != '#' }.each do |line|
            parse_service line.split('|')
          end

        when 'LOCATION.DE'
          ::Dpd::Location.truncate!
          data.lines.select { |line| line[0] != '#' }.each do |line|
            parse_location line.split('|')
          end

        when 'ROUTES'
          expiration_date = nil
          ::Dpd::Route.truncate!
          data.lines.each do |line|
            if line[0] != '#'
              parse_route line.split('|'), expiration_date
            elsif line.match(/#Expiration:/)
              year, month, day = line.scan(/#Expiration: ([\d]{4})([\d]{2})([\d]{2})/)[0]
              expiration_date = Date.new(year.to_i, month.to_i, day.to_i)
            end
          end
        end
      end
    end

    def parse_country(attr)
      ::Dpd::Country.create iso_country_code: attr[0],
                            iso_alpha_2_country_code: attr[1],
                            iso_alpha_3_country_code: attr[2],
                            destination_language:     attr[3],
                            flag_post_code_no:        attr[4]
    end

    def parse_depot(attr)
      ::Dpd::Depot.create number: attr[0],
                          i_ata_like_code:          attr[1],
                          group_id:                 attr[2],
                          name1:                    attr[3],
                          name2:                    attr[4],
                          address1:                 attr[5],
                          address2:                 attr[6],
                          post_code:                attr[7],
                          city_name:                attr[8],
                          iso_alpha_2_country_code: attr[9],
                          phone:                    attr[10],
                          fax:                      attr[11],
                          mail:                     attr[12],
                          web:                      attr[13]
    end

    def parse_service(attr)
      ::Dpd::Service.create code: attr[0],
                            text:     attr[1],
                            mark:     attr[2],
                            elements: attr[3]
    end

    def parse_location(attr)
      ::Dpd::Location.create area_name: attr[0],
                             city_name:                attr[1],
                             iso_alpha_2_country_code: attr[2],
                             post_code:                attr[3]
    end

    def parse_route(attr, expiration_date)
      ::Dpd::Route.create destination_country: attr[0],
                          begin_post_code:   attr[1],
                          end_post_code:     attr[2],
                          service_codes:     attr[3],
                          routing_places:    attr[4],
                          sending_date:      attr[5],
                          o_sort:            attr[6],
                          d_depot:           attr[7],
                          grouping_priority: attr[8],
                          d_sort:            attr[9],
                          barcode_id:        attr[10],
                          expiration_date: expiration_date
    end

    class << self

      def from_file( file_path )
        ::Dpd::Import.new( file_path ).write_routing_table
      end

    end
  end
end
