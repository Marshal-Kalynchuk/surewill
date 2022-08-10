class Subcription < ApplicationRecord
  belongs_to :user
  belongs_to :will

  validates :user, :will, :payed, presence: true
end
