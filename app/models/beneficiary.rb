class Beneficiary < ApplicationRecord
  belongs_to :will
  belongs_to :delegate
  accepts_nested_attributes_for :delegate

  has_many :bequests, as: :beneficiariable, dependent: :destroy
  has_many :assets, through: :bequests

  validates :will, :delegate, presence: true

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
