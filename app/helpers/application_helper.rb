module ApplicationHelper

	# List all Categories
	def categoryList
		Category.order('name ASC').all
	end


	# List all Counties
	def countyList
		County.order('name ASC').all
	end
	

end
