class WelcomeController < ApplicationController

	def index
		## MERGE CONFLICT ON THIS LINE
		@products = Product.order('id DESC').limit(6).where('enabled = ? AND deleted = ?',true, false)
		# @products = Product.order('id DESC').limit(6).where('enabled = ?',true)
		@images = carousel # method in application_controller.rb
	end

end
