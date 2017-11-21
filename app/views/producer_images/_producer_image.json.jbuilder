json.extract! producer_image, :id, :producer_id, :src, :primary_image, :created_at, :updated_at
json.url producer_image_url(producer_image, format: :json)
