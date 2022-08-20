class Delegate < ApplicationRecord
  include Collocable
  belongs_to :will

  validates :first_name, :last_name, :relation, :executor, :executor_rank, presence: true
  validates :executor_rank, presence: true, if: :executor

  scope :ordered, -> { order(id: :desc) }

  def full_name
    "#{self.first_name} #{self.middle_name} #{self.last_name}"
  end

end
