class Will < ApplicationRecord
  belongs_to :user

  has_one :testator, dependent: :destroy
  accepts_nested_attributes_for :testator

  has_many :beneficiaries, dependent: :destroy
  accepts_nested_attributes_for :beneficiaries


  # Executors
  has_many :executors, dependent: :destroy
  accepts_nested_attributes_for :executors

  # Bequests

  has_many :assets, dependent: :destroy
  accepts_nested_attributes_for :assets

  # Bequest

  has_many :bequests, through: :assets, dependent: :destroy
  accepts_nested_attributes_for :bequests

  has_many :accessors, dependent: :destroy

  # attr_accessor :releaser

  after_initialize :init, if: :new_record?

  validates :testator, :user, presence: true

  # after_save :send_release_email

  # def release_user_will(current_beneficiary)
  #   self.released = true
  #   self.releaser = current_beneficiary
  # end

  private

    # def send_release_email
    #   if saved_change_to_released? && self.released?
    #     self.beneficiaries.each do |beneficiary|
    #       WillMailer.will_beneficiary_released_email(self, beneficiary).deliver_now
    #     end
    #     WillMailer.will_testator_released_email(self).deliver_now
    #   end
    # end

    def init
      self.released = false 
      self.prepaid = false
    end

end
