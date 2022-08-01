class Mailer < ApplicationRecord
  has_one :user
  has_many :notifiers
end
