class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_admin!, only: [:index]
  # GET /orders
  # GET /orders.json
  def index
    if(customer_signed_in?) then
      @orders = Order.where('customer_id = ?', current_customer.id)
    elsif(admin_signed_in?) then
      render 'index'
    else
      @order = session['hamper0'] || []
      @total = @order.reduce(0) {|total, item| total + (item['q']*item['p'])}
      render 'session'
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  
  # A generic catch all redirect if there is an error with the unregistered order
  def custom_error
    # render 'order/error'
    # return false
  end

###########################################################################
######  THIS IS THE STRIPE ACTION TO CHARGE SOMEONE USING THE TOKEN #######
###########################################################################

  def create_charge
    if(@order)then
      Stripe.api_key = ENV['SECRET_KEY']
      token = @order.delivery_stripeToken
      charge = Stripe::Charge.create(
        :amount => @order.price.to_i,
        :currency => "eur",
        :description => "A fantastic custom hamper",
        :statement_descriptor => "Custom Hampers",
        :source => token,
      )
      custom_error if !charge
    else
      custom_error
    end
  end


###################################################
######  BELOW ARE THE ACTIONS FOR CREATING  #######
######  ENTITIES FOR UNREGISTERED CUSTOMERS #######
###################################################

  def create_unregistered_hamper 
    return Hamper.create({
                  customer_id:0, 
                  name:"My Hamper", 
                  price: @order.price, 
                  greeting:""
                })
  end

  def create_unregistered_order_item(hamper)
    return OrderItem.create({
                  hamper_id:hamper.id, 
                  order_id:@order.id
                })
  end

  def create_unregistered_hamper_item(item, hamper)
    return HamperItem.create({
                  hamper_id: hamper.id,
                  product_id: item['id'], 
                  price_when_ordered: item['p'], 
                  quantity: item['q'], 
                })
  end

  def create_unregistered_order
      @order = Order.create({
              customer_id: 0, 
              price: (params[:price].to_i * 100).to_i, 
              delivery_first_name: params[:firstname],
              delivery_last_name: params[:lastname],
              delivery_address: params[:address],
              delivery_address2: params[:address2],
              delivery_county_id: params[:county_id],
              delivery_contact_phone: params[:contact_phone],
              delivery_stripeToken: params[:stripeToken],
              delivery_stripeTokenType: params[:stripeTokenType],
              delivery_stripeEmail: params[:stripeEmail]
            })
      hamper = create_unregistered_hamper if @order
      @order_item = create_unregistered_order_item(hamper) if @order && hamper
      if hamper && @order then
        session['hamper0'].each do |item|
          hamper_item = create_unregistered_hamper_item(item, hamper)
          custom_error if !hamper_item
        end
      else
        custom_error
      end
      create_charge
  end

  
  # POST /orders
  # POST /orders.json
  def create
    if !customer_signed_in? then
      create_unregistered_order 
      redirect_to @order, notice: 'Order was successfully created.'
      reset_session
      return false
    end

    @order = Order.new(order_params)
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end    
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(
                                :price, 
                                :customer_id,
                                :authenticity_token,
                                :firstname,
                                :address1,
                                :address2,
                                :county_id,
                                :contact_phone,
                                :stripeToken,
                                :stripeTokenType,
                                :stripeEmail
                            )
    end
end
