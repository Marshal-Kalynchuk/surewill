module Asset
  extend ActiveSupport::Concern
  
  included do
    # Main
    belongs_to :will, counter_cache: true
    has_many :bequests, as: :asset, dependent: :destroy
    has_many :delegates, through: :bequests, source: :beneficiariable, source_type: "Delegate"
    
    # Primary, required.
    has_many :primary_bequests, -> { primary }, class_name: "Bequest", as: :asset, dependent: :destroy
    accepts_nested_attributes_for :primary_bequests, allow_destroy: true, reject_if: :all_blank
    has_many :primary_beneficiaries, through: :primary_bequests, source: :beneficiariable, source_type: "Delegate"

    validates :will, :primary_bequests, presence: true
    after_initialize :primary_valid?, unless: :new_record?

    #Secondary, optional. Specify validation at model level.
    has_many :secondary_bequests, -> { secondary }, class_name: "Bequest", as: :asset, dependent: :destroy
    accepts_nested_attributes_for :secondary_bequests, allow_destroy: true, reject_if: :all_blank
    has_many :secondary_beneficiaries, through: :secondary_bequests, source: :beneficiariable, source_type: "Delegate"
    
    def primary_valid?
      if self.primary_bequests.empty?
        self.errors.add(:primary_bequests, "can't be blank")
      end
      self.errors.empty?
    end
    def secondary_valid?
      if self.secondary_bequests.empty?
        self.errors.add(:secondary_bequests, "can't be blank")
      end
      self.errors.empty?
    end
  end
end