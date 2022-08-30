module Collocable
  extend ActiveSupport::Concern

  included do
    has_one :collocation, as: :collocable, dependent: :destroy
    has_one :address, through: :collocation
    accepts_nested_attributes_for :address, reject_if: :all_blank, allow_destroy: true

    delegate :full_address, to: :address, allow_nil: true

    def exempt_address
      self.address.postal_code = "exempt"
      self.address.line_1 = "exempt"
    end
  end
end