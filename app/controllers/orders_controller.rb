class OrdersController < ApplicationController
  
  # Customer (or admin) can only view own order_items
  before_action :order_items_permission, only: [:order_items]

  # Set @orders Variable
  before_action :set_order, only: [:show, :edit, :update, :destroy, :order_items]
  
  # before_action :authenticate_admin!, only: [:index]
  

  # Get Order Items - Ajax Request
  def order_items
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all
    render :layout => false
  end


  # GET /orders
  # GET /orders.json
  def index
    if(customer_signed_in?) then
      @orders = Order.where('customer_id = ?', current_customer.id).order(updated_at: :desc)
    elsif(admin_signed_in?) then
      @orders = Order.order(updated_at: :desc)
      render 'index'
    else
      @order = session['hamper0'] || []
      @total = @order.reduce(0) {|total, item| total + (item['q']*item['p'])}
      render 'unregistered_customer_order'
    end
    #@orders = Order.all
  end



  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    redirect_to :root, notice: 'There\'s nothing to see at the URL entered.'
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    redirect_to action: "show", id: @order.id
  end

  # A generic catch all redirect if there is an error with the unregistered order
  def custom_error
    render 'orders/error'
    return false
  end

  def verify
    if(customer_signed_in?) then
      # @order = Hamper.where('customer_id = ?', current_customer.id)
      @order = Hamper.where('customer_id = ? AND ordered = ?', current_customer.id, false)
      @total = price_multiple_hampers(@order) 
      @order.collect do | hamper |
        hamper.price = price_hamper(hamper)
      end
      render 'registered_customer_order'
    elsif(admin_signed_in?) then
      render 'index'
    else
      @order = session['hamper0']
      @total = @order.reduce(0) {|total, item| total + (item['q']*item['p'])}
      render 'unregistered_customer_order'
    end
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

  def create_order_item(hamper)
    return OrderItem.create({
                  hamper_id:hamper.id, 
                  order_id:@order.id
                })
  end

  def create_order
      @order = Order.create({
              customer_id: (customer_signed_in? && current_customer.id) || 0, 
              price: (params[:price].to_f * 100).to_i, 
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

    if !customer_signed_in? then
      hamper = create_hamper({price: @order.price}) if @order
      @order_item = create_order_item(hamper) if @order && hamper
      if hamper && @order then
        session['hamper0'].each do |item|
          hamper_item = create_hamper_item({product_id:item['id'], price:item['p'], quantity:item['q']}, hamper)
          custom_error if !hamper_item
        end
      else
        custom_error
      end
    else
      # hampers = Hamper.where('customer_id = ?', current_customer.id)
      hampers = Hamper.where('customer_id = ? AND ordered = ?', current_customer.id, false)
      hampers.each do | hamper |
        @order_item = create_order_item(hamper) if @order && hamper
      end 
    end

    create_charge
  end

  
  # POST /orders
  # POST /orders.json
  def create

      create_order 
      session.delete('hamper0') if(session['hamper0'])
      @order.order_items.each do |item|
        item.hamper.update(ordered: true)
      end 
      redirect_to @order, notice: 'Order was successfully created.'

  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    redirect_to action: "show", id: @order.id
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
                                :order_id,
                                :price, 
                                :customer_id,
                                :authenticity_token,
                                :lastname,
                                :address,
                                :address2,
                                :county_id,
                                :contact_phone,
                                :stripeToken,
                                :stripeTokenType,
                                :stripeEmail
                            )
    end


    # Check permission to view order items
    def order_items_permission
      if (!customer_signed_in? && !admin_signed_in?) || (customer_signed_in? && Order.find(params[:id]).customer_id != current_customer.id)
        return false
      end      
    end

end
