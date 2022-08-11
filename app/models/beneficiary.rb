class Beneficiary < ApplicationRecord
  belongs_to :will

  before_save :downcase_fields
  after_save :send_status_change_email
  
  ACCESSOR_TYPES = ['Executor', 'Beneficiary', 'Notificiary']
  validates :name, :email, :role, :will, presence: true
  validates :role, inclusion: { in: ACCESSOR_TYPES }

  def send_status_change_email
    if saved_change_to_email? 
      WillMailer.added_to_will_email(self.will, self).deliver_now 
    elsif saved_change_to_can_release? && self.can_release == true
      WillMailer.releaser_status_email(self.will, self).deliver_now
    end
  end

  private
  def downcase_fields
    self.email.downcase!
  end

end
