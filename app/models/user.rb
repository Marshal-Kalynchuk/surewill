class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  has_one :will
  has_many :subscriptions
  has_one :mailbox

  private
  def after_confirmation
    mailbox = Mailbox.find_by(email: self.email)
    if mailbox
      mailbox.user_id = self.id
      mailbox.save
    else
      mailbox = Mailbox.create(email: self.email, user_id: self.id)
    end
  end
end
