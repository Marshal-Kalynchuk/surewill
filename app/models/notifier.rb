class Notifier < ApplicationRecord
  belongs_to :will
  belongs_to :mailer
end
