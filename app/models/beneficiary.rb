class Beneficiary < ApplicationRecord
  belongs_to :will

  has_many :bequests, as: :benefactor, dependent: :destroy
  accepts_nested_attributes_for :bequests

  has_many :assets, through: :bequests

  ACCESSOR_TYPES = ['Executor', 'Beneficiary', 'Other']
  validates :first_name, :last_name, :role, :will, presence: true
  validates :note, length: { in: 10..200 }
  validates :role, inclusion: { in: ACCESSOR_TYPES }

  # before_save :downcase_fields
  # after_save :send_status_change_email

  # def send_status_change_email
  #   if saved_change_to_email? 
  #     WillMailer.added_to_will_email(self.will, self).deliver_now 
  #   elsif saved_change_to_can_release? && self.can_release == true
  #     WillMailer.releaser_status_email(self.will, self).deliver_now
  #   end
  # end

  private

  # def downcase_fields
  #   self.email.downcase!
  # end

end
