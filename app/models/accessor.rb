class Accessor < ApplicationRecord
  belongs_to :user
  belongs_to :will
  attr_accessor :email

  after_initialize :set_email, unless: :new_record?
  
  ACCESSOR_TYPES = ['Executor', 'Beneficiary', 'Notificiary']
  validates :name, :email, presence: true
  validates :accessor_type, inclusion: { in: ACCESSOR_TYPES }

  private
  def set_email
    self.email = self.user.email
  end

end
