module Collocable
  extend ActiveSupport::Concern

  included do
    has_one :collocation, as: :collocable, dependent: :destroy
    has_one :address, through: :collocation

    #delegate :full_addres, to: :postal_address, allow_nil: true
  end
end