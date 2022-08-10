class Accessor < ApplicationRecord
  belongs_to :will

  after_save :send_status_change_email
  
  ACCESSOR_TYPES = ['Testator','Executor', 'Beneficiary', 'Notificiary']
  validates :name, :email, :role, :will, presence: true
  validates :role, inclusion: { in: ACCESSOR_TYPES }

  def send_status_change_email
    if saved_change_to_user_id? 
      WillMailer.added_to_will_email(self.will, self).deliver_now 
    elsif saved_change_to_can_release? && self.can_release == true
      WillMailer.releaser_status_email(self.will, self).deliver_now
    end
  end

end
