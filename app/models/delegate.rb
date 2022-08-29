class Delegate < ApplicationRecord
  include Collocable
  belongs_to :will, counter_cache: true
  has_many :bequests, as: :beneficiariable, dependent: :destroy
  has_many :assets, through: :bequests, source: :asset

  before_validation :exempt_address

  validates :first_name, :last_name, :relation, presence: true

  scope :ordered, -> { order(id: :desc) }

  def full_name
    "#{self.first_name}#{" #{self.middle_name}" unless self.middle_name.nil?} #{self.last_name}".to_s
  end

  before_save :update_ranks, :set_rank
  after_destroy :update_ranks

  def initials
    "#{self.first_name.first}#{self.last_name.first}".upcase
  end

  def update_ranks
    if self.destroyed? && self.executor == true || self.executor_changed? && self.executor == false
      Delegate.where(will: self.will).where("executor_rank >= ?", self.executor_rank).each_with_index{|delegate, i| delegate.update(executor_rank: delegate.executor_rank - 1)}  
    end
    if self.destroyed? && self.guardian == true || self.guardian_changed? && self.guardian == false
      Delegate.where(will: self.will).where("guardian_rank >= ?", self.guardian_rank).each_with_index{|delegate, i| delegate.update(guardian_rank: delegate.guardian_rank - 1)}  
    end
  end

  def set_rank

    # Add skip if childless
    if self.guardian == true && self.guardian_changed?
      guardians = Delegate.where(will: self.will).where(guardian: true)
      if guardians.empty?
        self.guardian_rank = 1
      else
        self.guardian_rank = guardians.max_by { |guardian| guardian[:guardian_rank] }[:guardian_rank] + 1
      end
    elsif self.guardian == false
      self.guardian_rank = 0
    end

    if self.executor == true && self.executor_changed?
      executors = Delegate.where(will: self.will).where(executor: true)
      if executors.empty?
        self.executor_rank = 1
      else
        self.executor_rank = executors.max_by { |executor| executor[:executor_rank] }[:executor_rank] + 1
      end
    elsif self.executor == false
      self.executor_rank = 0
    end
  end

end
