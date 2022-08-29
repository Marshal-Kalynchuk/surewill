class Dependent < ApplicationRecord
  belongs_to :will, counter_cache: true

  def full_name
    "#{self.first_name} #{self.last_name}".to_s
  end

  def initials
    "#{self.first_name.first}#{self.last_name.first}".upcase
  end

end
