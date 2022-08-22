class Address < ApplicationRecord
  #validates :city, :zone, :zone_code, :country_code, :country, presence: true
  def full_address
    "#{number} #{street}, #{zipcode} #{city}, #{country_iso2}"
  end
end
