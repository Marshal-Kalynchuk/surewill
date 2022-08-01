json.extract! subscription, :id, :user_id, :will_id, :is_payed, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)
