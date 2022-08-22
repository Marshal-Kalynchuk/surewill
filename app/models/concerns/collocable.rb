module Collocable
  extend ActiveSupport::Concern

  included do
    has_one :collocation, as: :collocable, dependent: :destroy
    has_one :address, through: :collocation
    accepts_nested_attributes_for :address

    delegate :full_address, to: :address, allow_nil: true

    def exempt_address
      self.address.postal_code = "exempt"
      self.address.line_1 = "exempt"
    end
  end
end