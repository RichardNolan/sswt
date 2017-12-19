class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
 
  # Check if Producer/Customer is disabled, except for logging out
  before_action :user_enabled, :except => [:destroy]


  # Check if producer/customer is disabled by admin
  def user_enabled
    redirected = false
    if ((producer_signed_in? && current_producer.enabled == false) || (customer_signed_in? && current_customer.enabled==false)) && redirected == false
      redirected = true
      render 'producers/not_allowed'
    end
    false
  end


  # Carousel Images
  def carousel
    
    # Hash with carousel photos
    images = {}

    # How many photos to display
    total = 6
    (0..total-1).each { |n|
      images[n] = "#{n+1}.jpg"
    }
    return images

  end

  def get_hamper id
    return Hamper.find(id)
  end
	
	def create_hamper(val)
		return  Hamper.create({
              customer_id:(val[:customer_id] || 0), 
              name:(val[:name] || "My Hamper"), 
              price: (val[:price] || 0), 
              greeting:(val[:greeting] || "")
            })
  end

  def create_hamper_item(val, hamper)
    return  hamper.hamper_items.create(
              product_id: (val['product_id'] || val[:product_id]),  
              price_when_ordered: (val['price'] || val[:price]), 
              quantity: (val['quantity'] || val[:quantity])
            )
  end


  protected

    def after_sign_in_path_for(customer)
      # this function redirects the signed in customer to their profile
      
      if session['hamper0']
        hamper = create_hamper({customer_id:current_customer.id, name:"NEW HAMPER"})
        if hamper then
          session['hamper0'].each do |item|
            hamper_item = create_hamper_item({product_id:(item['id'] || item[:id]), price: (item['p'] || item[:p]), quantity: (item['q'] || item[:q])}, hamper)
          end
        end
        session.delete('hamper0')
      end
      signed_in_root_path(resource)
    end

    def configure_permitted_parameters
      # this allows the following parameters to be permitted, devise advises this goes here
      # These are for each devise action
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :first_name, :last_name,:address, :address2, :contact_phone, :county_id])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :first_name, :last_name, :address, :address2, :contact_phone, :county_id])
    end
end