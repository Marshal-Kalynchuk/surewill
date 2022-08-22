class Collocation < ApplicationRecord
  belongs_to :collocable, polymorphic: true
  belongs_to :address
end
