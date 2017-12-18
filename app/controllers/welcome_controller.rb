class WelcomeController < ApplicationController

	def index
		# IDEA ################################
		####### GET SORT ORDER FROM QUERYSTRING
		orderby = params[:orderby] || 'id'
		asc_desc = params[:order] || 'DESC'
		order = orderby+" "+asc_desc
		show = params[:show] || 6
		# EXAMPLES
		# http://localhost:3000/?order=desc    - homepage most recent
		# http://localhost:3000/?orderby=name&order=asc    -  homepage alphabetical
		# http://localhost:3000/?orderby=price&order=desc  -  dearest first
		# http://localhost:3000/?orderby=price&order=asc  -  cheapest first
		# default is latest products
		@products = Product.order(order).limit(show).where('enabled = ? AND deleted = ?',true, false)
		#######################################


		## MERGE CONFLICT ON THIS LINE
		# @products = Product.order('id desc').limit(6).where('enabled = ? AND deleted = ?',true, false)
		# @products = Product.order('id DESC').limit(6).where('enabled = ?',true)
		@images = carousel # method in application_controller.rb
	end

end
