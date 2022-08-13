class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :lockable, :timeoutable, :confirmable
         
  
  # Pay / strip payment
  pay_customer default_payment_processor: :stripe
  pay_customer stripe_attributes: :stripe_attributes

  # Pass values though to invite
  # attr_accessor :testator_name

  has_one :will, dependent: :destroy

  has_many :accessors, dependent: :destroy
  has_many :accessor_wills, through: :accessors, source: :will

  def stripe_attributes(pay_customer)
    {
      address: {
        city: pay_customer.owner.city,
        country: pay_customer.owner.country
      },
      metadata: {
        pay_customer_id: pay_customer.id,
        user_id: id # or pay_customer.owner_id
      }
    }
  end
  
end
