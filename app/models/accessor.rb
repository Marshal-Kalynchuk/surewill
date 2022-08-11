class Accessor < ApplicationRecord
  belongs_to :user
  belongs_to :will

  validates :user, :will, presence: true
end
