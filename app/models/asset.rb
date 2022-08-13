class Asset < ApplicationRecord
  belongs_to :will

  ASSET_TYPES = [ 'Property', 'Monetary', 'Other' ]
  validates :asset_type, :title, :description, presence: true
  validates :asset_type, inclusion: { in: ASSET_TYPES }
  validates :title, length: { in: 3..20 }

  # has_many_attached :images
end
