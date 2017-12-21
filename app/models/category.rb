class Category < ApplicationRecord
    
    # many to many
    has_and_belongs_to_many :products

   	# Validation Rules ------------------------------------
   	validates 	:name, 
   				presence: true, 
   				length: {maximum: 100}, 
   				uniqueness: {case_sensitive: false}

	mount_uploader :image, PictureUploader # mounting the PictureUploader on the src field of the ProductImage
end
