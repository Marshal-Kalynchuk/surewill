class Will < ApplicationRecord
  belongs_to :user
  # Testator
  has_one :testator, dependent: :destroy
  accepts_nested_attributes_for :testator
  # Delegates
  has_many :delegates, dependent: :destroy
  accepts_nested_attributes_for :delegates, reject_if: :all_blank, allow_destroy: true
  # Assets
  has_many :assets, dependent: :destroy
  accepts_nested_attributes_for :assets, reject_if: :all_blank, allow_destroy: true
  # Remaining estate
  has_many :remaining_estate_bequests, dependent: :destroy
  accepts_nested_attributes_for :remaining_estate_bequests, reject_if: :all_blank, allow_destroy: true

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
  def full_name
    "#{self.first_name} #{self.middle_name} #{self.last_name}"
  end
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

  def active_or_assets?
    self.status.include?('assets') || active?
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
