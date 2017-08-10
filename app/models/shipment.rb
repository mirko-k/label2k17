class Shipment < ApplicationRecord
  belongs_to :hauler
  belongs_to :merchant
  belongs_to :address
  accepts_nested_attributes_for :address
  has_many :parcels
  accepts_nested_attributes_for :parcels

  validates :hauler_id, :merchant_id, :parcels, presence: true
  validates :parcels, length: { minimum: 1, maximum: 100 }
  validates_numericality_of :parcel_count, greater_than_or_equal_to: 1
end
