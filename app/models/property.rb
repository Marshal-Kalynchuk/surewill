class Property < ApplicationRecord
  include Collocable
  include Asset
  
  PROPERTY_TYPES = [ 'Personal', 'Commercial' ]
  
  validates :secondary_bequests, :property_type, :title, :address, presence: true
  validates :property_type, inclusion: { in: PROPERTY_TYPES }
  validates :title, length: { in: 3..20 }

  after_initialize :secondary_valid?, unless: :new_record?

end
