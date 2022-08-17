json.extract! delegate, :id, :created_at, :updated_at
json.url delegate_url(delegate, format: :json)
