class Finance < ApplicationRecord
  belongs_to :will, counter_cache: true
end
