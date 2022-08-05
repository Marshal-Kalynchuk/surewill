class Will < ApplicationRecord

  # Associations
  belongs_to :user

  has_many :assets, dependent: :destroy
  accepts_nested_attributes_for :assets

  has_many :beneficiaries, dependent: :destroy
  accepts_nested_attributes_for :beneficiaries

  has_many :accessors, class_name: 'Subscription', dependent: :destroy
  accepts_nested_attributes_for :accessors

  # Validates
  validates :accessors, :assets, :beneficiaries, presence: true

  def released?
    self.released
  end
  def public?
    self.public
  end


end
