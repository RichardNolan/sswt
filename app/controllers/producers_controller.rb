class ProducersController < ApplicationController
  
  # Only Admin can see list of producers
  before_action :authenticate_admin!, only: [:index]

  
  # Admin or Producer can edit and update
  before_action :authenticate_producer! || :authenticate_admin!, only: [:edit, :update]


  # Default rails
  before_action :set_producer, only: [:show, :edit, :update, :destroy]
  

  # Index - List of Producers
  def index
    @producers = Producer.all
  end


  # View Producer Page
  def show
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
