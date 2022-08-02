class Will < ApplicationRecord
  belongs_to :user
  has_many :subscriptions
  has_many :mailboxes, through: :subscriptions
  accepts_nested_attributes_for :subscriptions

  # Validation:


  def mail_subs

  end

  def do_stuff

  end

end
