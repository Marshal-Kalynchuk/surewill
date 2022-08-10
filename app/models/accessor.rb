class Accessor < ApplicationRecord
  belongs_to :user
  belongs_to :will
  attr_accessor :email

  after_initialize :set_email, unless: :new_record?
  after_save :send_status_change_email
  
  ACCESSOR_TYPES = ['Executor', 'Beneficiary', 'Notificiary']
  validates :name, :email, presence: true
  validates :accessor_type, inclusion: { in: ACCESSOR_TYPES }

  def send_status_change_email
    if saved_change_to_user_id? 
      WillMailer.added_to_will_email(self.will, self).deliver_now 
    elsif saved_change_to_can_release? && self.can_release == true
      WillMailer.releaser_status_email(self.will, self).deliver_now
    end
  end

  private
  
  def set_email
    self.email = self.user.email
  end

end
