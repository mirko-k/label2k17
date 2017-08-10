class Address < ApplicationRecord
  has_many :shipments
  has_many :merchants

  validates :street, :city, :zip_code, :country_id, presence: true
  validates :name_1, presence: true, if: :company_name_empty?
  validates :company_name, length: { maximum: 35 }
  validates :name_1, length: { maximum: 35 }
  validates :name_2, length: { maximum: 35 }
  validates :street, length: { maximum: 43 }
  validates :city, length: { maximum: 35 }
  validates :additions, length: { maximum: 35 }
  validates :zip_code, length: { maximum: 9 }
  validates :telephone, length: { maximum: 30 }

  private

  def company_name_empty?
    company_name.blank?
  end

end
