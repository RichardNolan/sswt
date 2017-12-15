class Product < ApplicationRecord
    
	#has_many :product_like	

    belongs_to :producer		# product has FK producer_id
    has_many :product_images	# product PK used many times in product_image	
    has_many :hamper_items 		# product PK used many times in hamper_item
	
	# Product-Customer (Customer Likes Product) - many to many
	has_and_belongs_to_many :customers

	# Product-Categories - many to many
	has_and_belongs_to_many :categories

	
	accepts_nested_attributes_for :product_images, allow_destroy: true
end
