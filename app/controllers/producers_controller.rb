class ProducersController < ApplicationController
  
  # Only Admin can see list of producers, enable or disable
  before_action :authenticate_admin!, only: [:index, :destroy, :enable]

  
  # Producer can edit and update
  #before_action :authenticate_producer!, only: [:edit, :update]


  # Default rails
  before_action :set_producer, only: [:show, :edit, :update, :destroy, :enable]
  

  # Index - List of Producers
  def index
    @producers = Producer.all
  end


  # View Producer Page
  def show
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


  # Private ------------------------------------------------------------
  private

    
    # Set Producer variable
    def set_producer
      @producer = Producer.find(params[:id])
    end


    # Permitted Parameters
    def producer_params
      params.require(:producer).permit(:name, :email, :email_confirmed, :password, :address, :address2, :county_id, :contact_phone, :contact_email, :join_date, :enabled, :admin_notes, :about)
    end

end
