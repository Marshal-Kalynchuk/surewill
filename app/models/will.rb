class Will < ApplicationRecord
  belongs_to :user
  attr_accessor :releaser

  has_many :assets, dependent: :destroy
  accepts_nested_attributes_for :assets

  has_many :beneficiaries, dependent: :destroy
  accepts_nested_attributes_for :beneficiaries

  validates :beneficiaries, :assets, :user, presence: true


  after_save :send_release_email

  def release_user_will(current_beneficiary)
    self.released = true
    self.releaser = current_beneficiary
  end

  def public?
    self.public
  end

  private
    def send_release_email
      if saved_change_to_released? && self.released?
        self.beneficiaries.each do |beneficiary|
          WillMailer.will_beneficiary_released_email(self, beneficiary).deliver_now
        end
        WillMailer.will_testator_released_email(self).deliver_now
      end
    end

    def set_released
      self.released = false 
    end
end
