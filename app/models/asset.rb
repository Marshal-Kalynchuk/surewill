class Asset < ApplicationRecord
  belongs_to :will
  
  has_many :bequests, dependent: :destroy
  accepts_nested_attributes_for :bequests

  has_many :donations, through: :bequests, source: :beneficiariable, source_type: "Donation"
  has_many :beneficiaries, through: :bequests, source: :beneficiariable, source_type: "Beneficiary"

  ASSET_TYPES = [ 'Property', 'Monetary', 'Other' ]
  validates :asset_type, :title, :description, presence: true
  validates :asset_type, inclusion: { in: ASSET_TYPES }
  validates :title, length: { in: 3..20 }


end
