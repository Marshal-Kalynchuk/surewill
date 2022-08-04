class Beneficiary < ApplicationRecord
  belongs_to :will

  validates :name, presence: true

end
