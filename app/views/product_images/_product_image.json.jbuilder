json.extract! product_image, :id, :product_id, :src, :primary_image, :created_at, :updated_at
json.url product_image_url(product_image, format: :json)
