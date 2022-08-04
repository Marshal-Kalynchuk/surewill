class Will < ApplicationRecord
  belongs_to :user
  has_many :beneficiaries, dependent: :destroy
  has_many :users, through: :beneficiaries
  accepts_nested_attributes_for :beneficiaries

end
