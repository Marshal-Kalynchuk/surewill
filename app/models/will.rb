class Will < ApplicationRecord

  # Associations
  belongs_to :user

  has_many :assets, dependent: :destroy
  accepts_nested_attributes_for :assets

  has_many :accessors, dependent: :destroy
  accepts_nested_attributes_for :accessors

  has_one_attached :death_certificate

  # Validates
  validates :accessors, :assets, presence: true

  def released?
    self.released
  end
  def public?
    self.public
  end

end
