class WelcomeController < ApplicationController

	def index
		@products = Product.order('id DESC').limit(6).where('enabled = ? AND deleted = ?',true, false)
	end

end
