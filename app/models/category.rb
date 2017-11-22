class Category < ApplicationRecord
    
    # many to many relationship
    has_many :product_categories 	# category PK used many times on product_categories
    has_many :product, :through => :product_categories
    
end
