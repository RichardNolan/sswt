class WelcomeController < ApplicationController

	def index
		@products = Product.order('id DESC').limit(6).where('enabled = ? AND deleted = ?',true, false)
		@images = carousel # method in application_controller.rb
	end

end
