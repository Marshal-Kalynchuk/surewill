class Will < ApplicationRecord
  belongs_to :user
  attr_accessor :releaser

  has_many :assets, dependent: :destroy
  accepts_nested_attributes_for :assets

  has_many :accessors, dependent: :destroy
  accepts_nested_attributes_for :accessors

  validates :accessors, :assets, :user, presence: true


  after_save :send_release_email

  def release_user_will(current_accessor)
    self.released = true
    self.releaser = current_accessor
  end

  def public?
    self.public
  end

  private
    def send_release_email
      if saved_change_to_released? && self.released?
        self.accessors.each do |accessor|
          WillMailer.will_accessor_released_email(self, accessor).deliver_now
        end
        WillMailer.will_testator_released_email(self).deliver_now
      end
    end

    def set_released
      self.released = false 
    end
end
