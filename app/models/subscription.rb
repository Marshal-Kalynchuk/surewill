class Subscription < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :will
  belongs_to :mailbox
  attr_accessor :email

  # Validate email format next
  before_validation :link_user, :link_mailbox

  def link_user
    unless self.user_id
      user = User.find_by(email: self.email)
      if user
        self.user_id = user.id
      end
    end
  end
  def link_mailbox
    unless self.mailbox_id
      mailbox = Mailbox.find_by(email: self.email)
      unless mailbox 
        mailbox = Mailbox.create(email: self.email)
      end
      self.mailbox_id = mailbox.id
    end
  end
  def valid_email?

  end
end
