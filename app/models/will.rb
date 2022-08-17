class Will < ApplicationRecord
  belongs_to :user
  # Testator
  has_one :testator, dependent: :destroy
  accepts_nested_attributes_for :testator
  # Executors
  has_many :executors, dependent: :destroy
  accepts_nested_attributes_for :executors
  # Beneficiaries
  has_many :beneficiaries, dependent: :destroy
  accepts_nested_attributes_for :beneficiaries
  # Delegates
  has_many :delegates, dependent: :destroy
  accepts_nested_attributes_for :delegates, reject_if: :all_blank, allow_destroy: true
  # Assets
  has_many :assets, dependent: :destroy
  accepts_nested_attributes_for :assets
  # Bequests
  has_many :bequests, through: :assets, dependent: :destroy
  accepts_nested_attributes_for :bequests
  # Accessors
  has_many :accessors, dependent: :destroy

  after_initialize :init, if: :new_record?

  validates :testator,              presence: true, if: :active_or_testator?
  validates :delegates,             presence: true, if: :active_or_delegates?
  validates :assets,                presence: true, if: :active_or_assets?

  # after_save :send_release_email
  # def release_user_will(current_beneficiary)
  #   self.released = true
  #   self.releaser = current_beneficiary
  # end
  
  private

  def active?
    self.status == 'active'
  end
  
  def active_or_testator?
    self.status.include?('testator') || active?
  end

  def active_or_delegates?
    self.status.include?('delegates') || active?
  end

  def active_or_executors?
    self.status.include?('executors') || active?
  end

  def active_or_beneficiaries?
    self.status.include?('beneficiaries') || active?
  end

  def active_or_assets?
    self.status.include?('assets') || active?
  end

  def active_or_bequests?
    self.status.include?('bequests') || active?
  end

  def init
    self.status = 'blank'
    self.released = false 
    self.prepaid = false
  end

  # def send_release_email
  #   if saved_change_to_released? && self.released?
  #     self.beneficiaries.each do |beneficiary|
  #       WillMailer.will_beneficiary_released_email(self, beneficiary).deliver_now
  #     end
  #     WillMailer.will_testator_released_email(self).deliver_now
  #   end
  # end
end
