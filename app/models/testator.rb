class Testator < ApplicationRecord
  include Collocable
  belongs_to :will
  validates :first_name, :middle_name, :last_name, presence: true

  def full_name
    "#{self.first_name} #{self.middle_name} #{self.last_name}"
  end
  
end
