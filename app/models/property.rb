class Property < ApplicationRecord
  include Collocable
  belongs_to :will, counter_cache: true

  has_many :bequests, as: :asset, dependent: :destroy
  
  has_many :primary_bequests, -> { primary }, class_name: "Bequest", as: :asset, dependent: :destroy
  has_many :secondary_bequests, -> { secondary }, class_name: "Bequest", as: :asset, dependent: :destroy

  accepts_nested_attributes_for :primary_bequests, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :secondary_bequests, allow_destroy: true, reject_if: :all_blank

  has_many :primary_beneficiaries, through: :primary_bequests, source: :beneficiariable, source_type: "Delegate"
  has_many :secondary_beneficiaries, through: :secondary_bequests, source: :beneficiariable, source_type: "Delegate"
  has_many :delegates, through: :bequests, source: :beneficiariable, source_type: "Delegate"

  PROPERTY_TYPES = [ 'Personal', 'Commercial' ]
  validates :will, :primary_bequests, :secondary_bequests, :property_type, :title, :address, presence: true

  validates :property_type, inclusion: { in: PROPERTY_TYPES }
  validates :title, length: { in: 3..20 }

  after_initialize :primary_valid?, :secondary_valid?

  def primary_valid?
    if self.primary_bequests.empty?
      self.errors.add(:primary_bequests, "can't be blank")
    end
    self.errors.empty?
  end

  def secondary_valid?
    if self.secondary_bequests.empty?
      self.errors.add(:secondary_bequests, "can't be blank")
    end
    self.errors.empty?
  end

end
