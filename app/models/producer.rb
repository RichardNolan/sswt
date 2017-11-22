class Producer < ApplicationRecord
    has_many :products			# PK used many times in products
    has_many :producer_images  	# PK used many times in producer_images
end
