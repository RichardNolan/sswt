class HamperItemsController < ApplicationController
  before_action :set_hamper_item, only: [:show, :edit, :update, :destroy]

  def add
    # due to a limit on the cookie size of 4kb, we need to be economical with the data saved
    # to that end
    # h = hamper.id
    # id = product.id
    # q = quantity
    # p = price
    hamper_id = params['hamper_id'].to_i || 0
    quantity = params['quantity'].to_i || 1
    price = params['price'].to_f || 0
    product_id = params['product_id'].to_i || 0

    if(!customer_signed_in?)then
        # create a string name for the session which includes the hamper id
        hamper = 'hamper'+hamper_id.to_s

        # if the session variable doesn't exist create an empty array in one
        session[hamper] ||= []

        # flag for if an item exists in the hamper already
        already_in_hamper = false
        # interate over the array of items
        session[hamper].each do |item|
          # if the newly added object is in the hamper
          if(item['id']==product_id) then
            # just increment its quantity by the new quantity added
            item['q'] += quantity
            # set the flag
            already_in_hamper = true
          end 
        end
        # add the item to the array if not already in the hamper
        session[hamper].push( {h: hamper_id, id: product_id, q: quantity, p: price} ) if !already_in_hamper

        hamper_data = convert_session_hamper_into_hash(hamper).to_json

      else
        hamper_item = create_hamper_item({product_id:product_id, price: price, quantity: quantity}, get_hamper(hamper_id))
        hampers = Hamper.where('customer_id = ?', current_customer.id)
        hamper_data = hampers.to_json(:include => { :hamper_items => {  :include => { :product => {:only => :name } } } })
      end
      # respond ok and return the hamper
      head :ok, hampers: hamper_data, format: :json
  end

  def empty
    hamper_id = params[:hamper_id].to_i
    # delete it from session object
    puts hamper_id
    if hamper_id == 0 then
      session.delete('hamper0') 
    else
      hamper = Hamper.find(hamper_id)
      hamper.destroy if(hamper)
    end
    # respond ok and return what should be an empty array
    head :ok, hamper: [].to_json, format: :json
  end

  # RETURNS A JSON VERSION OF THE HAMPERS BELONGING TO THE CUSTOMER - FROM EITHER THE SESSION OR DB
  def get_hamper_data
    hamper_data = convert_session_hamper_into_hash("hamper0") if(!customer_signed_in?)
    hamper_data = Hamper.where('customer_id = ?', current_customer.id).to_json(:include => { :hamper_items => {  :include => { :product => {:only => :name } } } }) if(customer_signed_in?)
    head :ok, hampers: hamper_data, format: :json
  end

  def convert_session_hamper_into_hash(hamper)
    session[hamper] ||= []
    price = 0
    # with the small session saved we add some extra data required for the hamper view, like product name
    hamper_items = session[hamper].collect do |item| 
      id = item['id'] || item[:id]
      q = item['q'] || item[:q]
      p = item['p'] || item[:p]
      h = item['h'] || item[:h]
      price += (p * q)
      product = {name: Product.find(id).name || 'unknown'}
      item = item.merge({product: product, product_id:id, quantity:q, price_when_ordered:p, hamper_id:h})
    end
    return [{name:"My Hamper", price: price, greeting:"", hamper_items:hamper_items}]
  end


  # GET /hamper_items
  # GET /hamper_items.json
  def index
    @hamper_items = HamperItem.all
  end

  # GET /hamper_items/1
  # GET /hamper_items/1.json
  def show
  end

  # GET /hamper_items/new
  def new
    @hamper_item = HamperItem.new
  end

  # GET /hamper_items/1/edit
  def edit
  end

  # POST /hamper_items
  # POST /hamper_items.json
  def create
    @hamper_item = HamperItem.new(hamper_item_params)

    respond_to do |format|
      if @hamper_item.save
        format.html { redirect_to @hamper_item, notice: 'Hamper item was successfully created.' }
        format.json { render :show, status: :created, location: @hamper_item }
      else
        format.html { render :new }
        format.json { render json: @hamper_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hamper_items/1
  # PATCH/PUT /hamper_items/1.json
  def update
    respond_to do |format|
      if @hamper_item.update(hamper_item_params)
        format.html { redirect_to @hamper_item, notice: 'Hamper item was successfully updated.' }
        format.json { render :show, status: :ok, location: @hamper_item }
      else
        format.html { render :edit }
        format.json { render json: @hamper_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hamper_items/1
  # DELETE /hamper_items/1.json
  def destroy
    @hamper_item.destroy
    respond_to do |format|
      format.html { redirect_to hamper_items_url, notice: 'Hamper item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hamper_item
      @hamper_item = HamperItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hamper_item_params
      params.require(:hamper_item).permit(:hamper_id, :product_id, :quantity, :price_when_ordered)
    end
end
