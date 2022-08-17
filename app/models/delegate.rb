class Delegate < ApplicationRecord
  include Collocable
  belongs_to :will

  has_one :beneficiary
  accepts_nested_attributes_for :beneficiary, allow_destroy: true

  has_one :executor
  accepts_nested_attributes_for :executor, allow_destroy: true

  validates :first_name, :last_name, :relation, presence: true
  #validates :first_name, uniqueness: { scope: [:will_id, :middle_name, :last_name] }

  scope :ordered, -> { order(id: :desc) }

  def full_name
    "#{self.first_name} #{self.middle_name} #{self.last_name}"
  end


end
