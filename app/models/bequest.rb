class Bequest < ApplicationRecord
  belongs_to :asset
  belongs_to :beneficiariable, polymorphic: true
  validates :asset, :beneficiariable, presence: true
end
