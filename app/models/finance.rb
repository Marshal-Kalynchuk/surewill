class Finance < ApplicationRecord
  belongs_to :will, counter_cache: true

  has_many :bequests, as: :asset, dependent: :destroy
  has_many :beneficiaries, through: :bequests, source:  :beneficiariable, source_type: 'Delegate'
  accepts_nested_attributes_for :bequests, allow_destroy: true, reject_if: :all_blank
  FINANCE_TYPES = ['agfs', 'lgfs']

  validates :will, :bequests, :finance_type, presence: true
  validates :finance_type, inclusion: { in: FINANCE_TYPES }
end
