json.extract! product_like, :id, :product_id, :customer_id, :created_at, :updated_at
json.url product_like_url(product_like, format: :json)
