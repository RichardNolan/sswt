class CustomersController < ApplicationController
  
  # Only Admin can see list of customers, enable or disable
  before_action :authenticate_admin!, only: [:index, :destroy, :enable]

  
  # Set Customer Variable
  before_action :set_customer, only: [:show, :destroy, :enable]
  


    # Index - List of Producers
  def index
    @customers = Customer.all
  end


  # View Customer Page
  def show
    if (customer_signed_in? && current_customer.id == @customer.id) || admin_signed_in?
      @hampers = Hamper.where("customer_id = ? AND ordered = ?", @customer.id, false)
      @orders = Order.where("customer_id = ?", @customer.id)      
    elsif (!customer_signed_in? && !admin_signed_in?) || (customer_signed_in? && @customer.id != current_customer.id && !admin_signed_in?) 
      redirect_to root_url    
    end
      
  end


  # Disable Customer
  def destroy
    @customer.enabled = false
    @customer.save
    redirect_to @customer
  end


  # Enable Customer
  def enable
    @customer.enabled = true
    @customer.save
    redirect_to @customer
  end


  # Private ------------------------------------------------------------
  private

    # Set customer variable
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Permitted parameters
    def customer_params
      params.require(:customer).permit( :first_name, 
                                        :last_name, 
                                        :email, 
                                        :password, 
                                        :email_confirmed, 
                                        :join_date, 
                                        :address, 
                                        :address2, 
                                        :county_id, 
                                        :enabled, 
                                        :admin_notes)
    end
end
