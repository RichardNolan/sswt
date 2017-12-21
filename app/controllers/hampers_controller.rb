class HampersController < ApplicationController

  # Customer can only view own hampers || Admin can view all hampers
  before_action :create_hamper_list, only: [:index]

  # Set @hamper variable
  before_action :set_hamper, only: [:show, :edit, :update, :destroy, :hamper_items]

  # Customer (or admin) can only view own hamper_items
  before_action :get_hamper_items, only: [:hamper_items]


  # Get Hamper Items - Ajax Request
  def hamper_items
    @hamper_items = get_hamper_items
    render :layout => false
  end


  # Create Hamper
  def create_hamper
    hamper = current_customer.hampers.create({name:params[:hamper_name], price:0, greeting:""})
    # respond ok and return the hamper
    head :ok, hamper: hamper.to_json, format: :json
  end


  # List Hampers
  def index
  end



  # Delete Hamper
  def destroy
    @hamper.destroy
    redirect_to hampers_url, notice: 'Hamper was successfully deleted.'
  end


  # Delete Product (Hamper Item)
  def delete_hamper_item
    @hamper_item = HamperItem.find(params[:id])
    @hamper = Hamper.find(@hamper_item.hamper_id)
    @hamper_item.destroy
    redirect_to hampers_url, notice: "Product removed from hamper.";
  end


  # Private methods --------------------------
  private

    # Set @hamper variable
    def set_hamper
      @hamper = Hamper.find(params[:id])
    end

    # Permitted parameters
    def hamper_params
      params.require(:hamper).permit(:customer_id, :name, :price, :greeting)
    end


    # Create hamper list depending on user being Customer or Admin
    def create_hamper_list

      # if not logged in...
      if !admin_signed_in? && !customer_signed_in?
        redirect_to root_url
      end

      # Customer List
      if customer_signed_in?
        # @hampers = Hamper.where(:customer_id => current_customer.id)
        @hampers = Hamper.where("customer_id = ? AND ordered = ?", current_customer.id, false)
      end

      # Admin List
      if admin_signed_in?
        @hampers = Hamper.all
      end

    end


    # Customer (or admin) can only view own hamper_items
    def get_hamper_items
      # not admin...
      if !admin_signed_in? 
        if (customer_signed_in? && current_customer.id != @hamper.customer_id) || !customer_signed_in?
          render 'producers/not_allowed'
        end        
      end

      hamper_id = params[:id]    
      @hamper_items = @hamper.hamper_items
    
    end

end
