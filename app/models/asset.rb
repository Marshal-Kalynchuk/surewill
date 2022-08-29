class Asset < ApplicationRecord
  include Collocable
  belongs_to :will, counter_cache: true
  has_many :bequests, dependent: :destroy
  accepts_nested_attributes_for :bequests, allow_destroy: true, reject_if: :all_blank
  has_many :beneficiaries, through: :bequests, source: :beneficiariable, source_type: "Delegate"
  
  validates :bequests, :title, presence: true
  validates :title, length: { in: 3..20 }
  after_initialize :bequests_valid?, unless: :new_record?

  def bequests_valid?
    if self.bequests.empty?
      self.errors.add(:beneficiaries, "can't be blank")
    end
    self.errors.empty?
  end

end
