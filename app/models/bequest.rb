class Bequest < ApplicationRecord
  belongs_to :assetable, polymorphic: true
  belongs_to :beneficiariable, polymorphic: true
  validates :assetable, :beneficiariable, :percentage, presence: true
end
