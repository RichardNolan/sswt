class WelcomeController < ApplicationController

	def index
		@products = Product.order('id DESC').limit(6).all
	end

end
