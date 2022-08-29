class Asset < ApplicationRecord
  include Collocable
  belongs_to :will, counter_cache: true
  has_many :bequests, as: :asset, dependent: :destroy
  accepts_nested_attributes_for :bequests, allow_destroy: true, reject_if: :all_blank
  has_many :beneficiaries, through: :bequests, source: :beneficiariable, source_type: "Delegate"
  
  validates :bequests, :title, presence: true
  validates :title, length: { in: 3..20 }


end
