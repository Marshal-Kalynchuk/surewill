class Address < ApplicationRecord
  validates :line_1, :postal_code, :city, :zone, :country_code, presence: true
  def full_address
    "#{number} #{street}, #{zipcode} #{city}, #{country_code}"
  end
end
