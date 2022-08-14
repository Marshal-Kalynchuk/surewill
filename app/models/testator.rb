class Testator < ApplicationRecord
  include Collocable
  belongs_to :will
  validates :first_name, :last_name, presence: true
end
