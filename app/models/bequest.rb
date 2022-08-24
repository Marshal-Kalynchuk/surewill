class Bequest < ApplicationRecord
  belongs_to :asset, polymorphic: true
  belongs_to :beneficiariable, polymorphic: true
  scope :primary, -> { where(primary: 1) }
  scope :secondary, -> { where(primary: 0) }

  validates :asset, :beneficiariable, :percentage, :primary, presence: true

  after_initialize :set_primary, if: :new_record?

  private
    def set_primary
      self.primary = 1 if self.primary.nil?
    end
end
