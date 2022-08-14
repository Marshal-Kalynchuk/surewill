class Asset < ApplicationRecord
  belongs_to :will
  
  has_many :bequests, dependent: :destroy
  accepts_nested_attributes_for :bequests

  ASSET_TYPES = [ 'Property', 'Monetary', 'Other' ]
  validates :asset_type, :title, :description, presence: true
  validates :asset_type, inclusion: { in: ASSET_TYPES }
  validates :title, length: { in: 3..20 }

  # has_many_attached :images
end
