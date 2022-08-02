class Mailbox < ApplicationRecord
  belongs_to :user, optional: true
  validates :email, presence: true
  validates :email, uniqueness: true
 
end
