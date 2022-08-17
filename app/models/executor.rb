class Executor < ApplicationRecord
  belongs_to :will
  belongs_to :delegate

  accepts_nested_attributes_for :delegate
  validates :will, :delegate, :rank, presence: true
end
