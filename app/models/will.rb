class Will < ApplicationRecord
  belongs_to :user
  has_many :subscriptions
  # has_many :notifiers

  validates :user, presence: true

end
