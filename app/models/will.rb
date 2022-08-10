class Will < ApplicationRecord

  # Associations
  belongs_to :user

  has_many :assets, dependent: :destroy
  accepts_nested_attributes_for :assets

  has_many :accessors, dependent: :destroy
  accepts_nested_attributes_for :accessors

  has_many :accessor_users, through: :accessors, source: :user

  # Validates
  validates :accessors, :assets, presence: true

  before_create :set_released

  def set_released
    self.released = false 
  end

  def released?
    self.released
  end
  
  def public?
    self.public
  end


end
