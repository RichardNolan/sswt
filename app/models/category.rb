class Category < ApplicationRecord
    
    # Relationships ---------------------------------------
    # many to many relationship
    has_many 	:product_categories 	# category PK used many times on product_categories
    has_many 	:product, :through => :product_categories
   

   	# Validation Rules ------------------------------------
   	validates 	:name, 
   				presence: true, 
   				length: {maximum: 100}, 
   				uniqueness: {case_sensitive: false}

   	


end
