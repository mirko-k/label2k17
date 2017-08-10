class Merchant < ApplicationRecord
  has_many :shipments
  belongs_to :address
  accepts_nested_attributes_for :address
  validates :name, presence: true
  validates :name, length: { maximum: 35 }
end
