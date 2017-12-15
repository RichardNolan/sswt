module ApplicationHelper

	# List all Categories
	def categoryList
		Category.order('name ASC').all
	end


	# List all Counties
	def countyList
		County.order('name ASC').all
	end
	

	def primary_product_image id
		primary_image = ProductImage.where('product_id = ?', id)
		primary_image = primary_image.where('primary_image = ?', true).first || primary_image.first
		(primary_image = primary_image.src if primary_image) || "/images/placeholder.jpg"
	end
	
end
