class Asset < ApplicationRecord
  belongs_to :will
  has_one_attached :image

  validates :title, :description, presence: true
  validates :title, length: { in: 3..20 }

  # has_many_attached :images
end
