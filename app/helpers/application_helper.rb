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
	
	def product_name id
		return Product.find(id).name
	end	
	
	def currency(num)
		num = 0 if !num
		return "€" + sprintf("%20.2f", num)
	end
	
	def price_hamper hamper
		return currency(hamper.hamper_items.reduce(0) do | total, item |
		  total += (item.price_when_ordered * item.quantity)
		end)
	  end

	  
	def price_multiple_hampers hampers
		return currency(hampers.reduce(0) do | total, hamper |
		total += price_hamper(hamper)
		end)
	end
end
