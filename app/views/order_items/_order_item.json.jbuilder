json.extract! order_item, :id, :order_id, :hamper_id, :created_at, :updated_at
json.url order_item_url(order_item, format: :json)
