class Address < ApplicationRecord
  validates :line_1, :postal_code, :city, :zone, :country_code, presence: true

  def full_address
    "#{self.line_1}, #{self.postal_code} #{self.city}, #{self.zone}, #{self.country_code}"
  end
  
  def short_line_address
    "#{self.line_1}, #{self.city}, #{self.country_code}"
  end

  def formatted_address
    "#{self.city}, Country of #{self.country_code}, State of #{self.zone}"
  end

  def short_broad_address
    "#{self.city}, #{self.zone}, #{self.country_code}"
  end

end
