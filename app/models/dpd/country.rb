module Dpd
  class Country < ApplicationRecord
    self.table_name_prefix = 'dpd_'
  end
end
