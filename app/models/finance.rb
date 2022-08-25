class Finance < ApplicationRecord
  include Asset

  FINANCE_TYPES = ['agfs', 'lgfs']
  validates :finance_type, presence: true
  validates :finance_type, inclusion: { in: FINANCE_TYPES }
end
