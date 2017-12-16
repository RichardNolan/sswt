class WelcomeController < ApplicationController

	def index
		@products = Product.order('id DESC').limit(6).where('enabled = ?',true)
		@images = carousel # method in application_controller.rb
	end

end
