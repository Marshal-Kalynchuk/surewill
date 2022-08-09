class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  # Pass values though to invite
  attr_accessor :testator_name

  has_one :will, dependent: :destroy

  has_many :acccessors, dependent: :destroy
  has_many :accessor_wills, class_name: 'Will', through: :accessors
  
end
