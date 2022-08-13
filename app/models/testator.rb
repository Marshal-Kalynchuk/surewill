class Testator < ApplicationRecord
  belongs_to :will
  validates :first_name, :middle_name, :last_name, :line_1, :city, :country, presence: true
end
