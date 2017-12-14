module ApplicationHelper

	# List all Categories
	def categoryList
		Category.order('name ASC').all
	end


	# List all Counties
	def countyList
		County.order('name ASC').all
	end
	
	def currency(num)
		num = 0 if !num
		return "€" + sprintf("%20.2f", num)
	end
end
