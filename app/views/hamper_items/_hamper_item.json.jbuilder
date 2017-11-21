json.extract! hamper_item, :id, :hamper_id, :product_id, :quantity, :price_when_ordered, :created_at, :updated_at
json.url hamper_item_url(hamper_item, format: :json)
