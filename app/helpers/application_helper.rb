module ApplicationHelper

	# List all Categories
	def categoryList
		Category.order('name ASC').all
	end


	# List all Counties
	def countyList
		County.order('name ASC').all
	end
	

	def primary_image id
		# # the primary image is the first one with the primary_image value of true. If theres none, take the first image
		# primary_image = ProductImage.where('product_id = ? and primary_image = ?', id, true) || ProductImage.where('product_id = ?', id)

		# if primary_image.first then
		# 	puts '###################'+ primary_image.first.src.to_s
		#   primary_image = primary_image.first.src.to_s
		# else
		#   primary_image = "/images/placeholder.jpg"
		# end 
		# return primary_image

		# # the primary image is the first one with the primary_image value of true. If theres none, take the first image
		# primary_image = "/images/placeholder.jpg"

		# return primary_image

		primary_image = ProductImage.where('product_id = ?', id)
		primary_image = primary_image.where('primary_image = ?', true).first || primary_image.first
		(primary_image = primary_image.src if primary_image) || "/images/placeholder.jpg"
	end
	
end
