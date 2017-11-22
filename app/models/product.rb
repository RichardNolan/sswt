class Product < ApplicationRecord
    
	#has_many :product_like	

    belongs_to :producer		# product has FK producer_id
    has_many :product_images	# product PK used many times in product_image	
    has_many :hamper_items 		# product PK used many times in hamper_item
	
	# many to many relationship
	has_many :product_likes		# product PK used many times in product_likes
	has_many :customers, :through => :product_likes

	# many to many
	has_many :product_categories	# product PK used many times in product_category
	has_many :categories, :through => :product_categories
end
