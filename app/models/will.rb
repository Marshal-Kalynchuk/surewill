class Will < ApplicationRecord
  belongs_to :user

  has_many :assets, dependent: :destroy
  accepts_nested_attributes_for :assets

  has_many :beneficiaries, dependent: :destroy
  accepts_nested_attributes_for :beneficiaries
  
end
