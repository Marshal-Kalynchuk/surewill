class Delegate < ApplicationRecord
  include Collocable
  belongs_to :will
  has_many :bequests, as: :beneficiariable, dependent: :destroy
  has_many :assets, through: :bequests

  validates :first_name, :last_name, :relation, presence: true

  scope :ordered, -> { order(id: :desc) }

  def full_name
    "#{self.first_name} #{self.middle_name} #{self.last_name}"
  end

end
