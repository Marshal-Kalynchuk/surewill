class Address < ApplicationRecord
  def full_address
    #"#{number} #{street}, #{zipcode} #{city}, #{country_iso2}"
  end
end
