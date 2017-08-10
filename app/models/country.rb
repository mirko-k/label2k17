class Country < ApplicationRecord
  has_many :addresses
  validates :name, :alpha2_code, presence: true
  validates :name, length: { maximum: 35 }
  validates :alpha2_code, length: { maximum: 2 }
end
