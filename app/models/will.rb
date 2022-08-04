class Will < ApplicationRecord

  # Associations
  belongs_to :user

  has_many :assets, dependent: :destroy
  accepts_nested_attributes_for :assets

  has_many :beneficiaries, dependent: :destroy
  accepts_nested_attributes_for :beneficiaries

  has_many :accessors, class_name: 'Subscriber', dependent: :destroy
  accepts_nested_attributes_for :accessors

  # Validates
  validates :accessors, :assets, :beneficiaries, presence: true


end
