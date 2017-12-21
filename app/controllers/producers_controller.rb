class ProducersController < ApplicationController
  
  # Only Admin can see list of producers, enable or disable
  before_action :authenticate_admin!, only: [:index, :destroy, :enable]

  # Set producer variable
  before_action :set_producer, only: [:show, :destroy, :enable, :products]
  
  
  # Index - List of Producers
  def index
    @producers = Producer.all
  end

  # View Producer Page
  def show
    @products = @producer.products.all
  end

  def edit
    @producer.producer_images.build
  end 

  # Producer Products page
  def products
    @products = @producer.products.all
  end


  # Disable Producer
  def destroy
    @producer.enabled = false
    @producer.save
    redirect_to @producer
  end


  # Enable Producer
  def enable
    @producer.enabled = true
    @producer.save
    redirect_to @producer
  end


  # Producer not allowed page
  def not_allowed
  end

  def orders
    @producer_orders = HamperItem
                          .select('hamper_items.id, products.name, products.producer_id')
                          .joins(:product)
                          .where('products.producer_id = ?', current_producer.id) # this should be the last
    @json = HamperItem.all.to_json(:include => { :product => {:include => :producer}   })
  end
  


  # Private ------------------------------------------------------------
  private

    
    # Set Producer variable
    def set_producer
      @producer = Producer.find(params[:id])
    end


    # Permitted Parameters
    def producer_params
      params.require(:producer).permit(
                                  :name, 
                                  :email, 
                                  :email_confirmed, 
                                  :password, 
                                  :address, 
                                  :address2, 
                                  :county_id, 
                                  :contact_phone, 
                                  :contact_email, 
                                  :join_date, 
                                  :enabled, 
                                  :admin_notes,
                                  :about,
                                  producer_images_attributes:[:src, :id]
                              )
    end


end
