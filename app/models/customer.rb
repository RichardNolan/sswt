class Customer < ApplicationRecord
    has_many :product_likes
    has_many :hampers
end
