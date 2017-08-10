class Hauler < ApplicationRecord
  has_many :shipments
  validates :name, presence: true
  validates :name, length: { maximum: 35 }
end
