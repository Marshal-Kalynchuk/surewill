class Accessor < ApplicationRecord
  belongs_to :user
  belongs_to :will

  validates :user, :will, :can_release, :payed, presence: true
  
end
