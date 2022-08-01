class Will < ApplicationRecord
  belongs_to :user
  has_many :subscriptions

  validates :user, presence: true

end
