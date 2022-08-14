class Executor < ApplicationRecord
  belongs_to :beneficiary
  belongs_to :will
end
