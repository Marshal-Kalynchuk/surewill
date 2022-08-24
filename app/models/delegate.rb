class Delegate < ApplicationRecord
  include Collocable
  belongs_to :will, counter_cache: true
  has_many :bequests, as: :beneficiariable, dependent: :destroy
  has_many :properties, through: :bequests, source: :asset, source_type: "Property"

  before_validation :exempt_address

  validates :first_name, :last_name, :relation, presence: true

  scope :ordered, -> { order(id: :desc) }

  def full_name
    "#{self.first_name} #{self.middle_name} #{self.last_name}"
  end

  before_save :update_ranks, :set_rank
  after_destroy :update_ranks

  def initials
    "#{self.first_name.first}#{self.last_name.first}".upcase
  end

  def update_ranks
    if self.destroyed? && self.executor == 1 || self.executor_changed? && self.executor == 0
      Delegate.where(will: self.will).where("executor_rank >= ?", self.executor_rank).each_with_index{|delegate, i| delegate.update(executor_rank: delegate.executor_rank - 1)}  
    end
  end

  def set_rank
    if self.executor == 1 && self.executor_changed?
      executors = Delegate.where(will: self.will).where(executor: true)
      if executors.empty?
        self.executor_rank = 1
      else
        self.executor_rank = executors.max_by { |executor| executor[:executor_rank] }[:executor_rank] + 1
      end
    elsif self.executor == 0
      self.executor_rank = 0
    end
  end

end
