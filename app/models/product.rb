class Product < ApplicationRecord
    belongs_to :producer
    has_many :product_images
    has_many :product_likes
end
