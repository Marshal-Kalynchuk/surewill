class Bequest < ApplicationRecord
  belongs_to :asset
  belongs_to :benefactor, polymorphic: true
end
