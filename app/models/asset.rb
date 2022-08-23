class Asset < ApplicationRecord
  belongs_to :will
  
  has_many :bequests, as: :assetable, dependent: :destroy
  accepts_nested_attributes_for :bequests
  has_many :beneficiaries, through: :bequests, source: :beneficiariable, source_type: "delegate"

  ASSET_TYPES = [ 'Property', 'Monetary', 'Other' ]
  validates :will, :asset_type, :title, :description, presence: true
  validates :asset_type, inclusion: { in: ASSET_TYPES }
  validates :title, length: { in: 3..20 }

  validates :bequests, presence: { message: "Beneficiaries can't be blank." }
  
end
