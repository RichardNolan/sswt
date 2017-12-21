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
    # this returns an array of the ids of all the producers products
    producer_products = Product.where('producer_id = ?', current_producer.id).pluck(:id)
    # use the array to query all hamper_items containing an item from the array
    @producer_hamper_items = HamperItem.where(product_id: producer_products)

    # using pluck again we get the ids of all the hampers containing these items
    hamper_ids = @producer_hamper_items.pluck(:hamper_id)
    # use the array to get the ordered hampers
    @producer_orders = Hamper.where(id: hamper_ids, ordered: true).order(updated_at: :desc)

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
