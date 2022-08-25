class Belonging < ApplicationRecord
  include Asset

  validates :title, :description, presence: true
  validates :title, length: { in: 3..20 }
  validates :description, length: { in: 10..100 }
end
