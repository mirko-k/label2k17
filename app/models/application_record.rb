# app/models/application_record.rb
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  class << self
    def truncate!
      connection.execute("TRUNCATE TABLE #{quoted_table_name}")
    end
  end
end
