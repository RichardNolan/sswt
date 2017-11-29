class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Before an action on any instance run county_list
  # This seems like overkill having this on every instance, but it is global
  #before_action :county_list
  

  protected
    #def county_list
      # populate @counties instance variable
      #@counties = County.order('name ASC').all
    #end

    def configure_permitted_parameters
      # this allows the following parameters to be permitted, devise advises this goes here
      # These are for each devise action
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :first_name, :last_name,:address, :address2, :contact_phone, :county_id])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :first_name, :last_name, :address, :address2, :contact_phone, :county_id])
    end
end