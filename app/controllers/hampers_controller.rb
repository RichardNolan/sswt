class HampersController < ApplicationController
  before_action :set_hamper, only: [:show, :edit, :update, :destroy]
  before_action :set_hampers, only: [:index]

  # GET /hampers
  # GET /hampers.json
  def index
    render layout: "modal"
  end

  # GET /hampers/1
  # GET /hampers/1.json
  def show
  end

  # GET /hampers/new
  def new
    @hamper = Hamper.new
  end

  # GET /hampers/1/edit
  def edit
  end

  # POST /hampers
  # POST /hampers.json
  def create
    @hamper = Hamper.new(hamper_params)

    respond_to do |format|
      if @hamper.save
        format.html { redirect_to @hamper, notice: 'Hamper was successfully created.' }
        format.json { render :show, status: :created, location: @hamper }
      else
        format.html { render :new }
        format.json { render json: @hamper.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hampers/1
  # PATCH/PUT /hampers/1.json
  def update
    respond_to do |format|
      if @hamper.update(hamper_params)
        format.html { redirect_to @hamper, notice: 'Hamper was successfully updated.' }
        format.json { render :show, status: :ok, location: @hamper }
      else
        format.html { render :edit }
        format.json { render json: @hamper.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hampers/1
  # DELETE /hampers/1.json
  def destroy
    @hamper.destroy
    respond_to do |format|
      format.html { redirect_to hampers_url, notice: 'Hamper was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def create_session_hamper
      return {customer_id:0, name: "My Hamper", price: get_hamper_price(session['hamper0']), greeting:"", hamper_items: session['hamper0']}
    end

    def load_db_hamper
      hamper = Hamper.find(params[:id])
      hamper[:price] = get_hamper_price(hamper.hamper_items)
      # hamper[:hamper_items] = add_product_names(hamper.hamper_items)
      return hamper
    end

    def get_hamper_price(items)
      return items ? items.reduce(0){ |total_price, item|
        # Because this function equates the value of hampers from two sources Sessions and Database
        # and because they have different keys, due to the 4kb cookie limit
        # creates vars for the price and quantity from either version of keys
        quantity  =   item['q'] || item.quantity
        price     =   item['p'] || item.price_when_ordered

        total_price+=(  quantity * price    )
      } : 0
    end
    
    # def add_product_names(items)
    #   return items ? items.map {|item| add_product_name(item) } : nil
    # end

    # def add_product_name(item)
    #   new_item = {}
    #   new_item['product_id']    = item.product_id || item['id']
    #   new_item['quantity']    = item.quantity || item['q']
    #   new_item['price_when_ordered']    = item.price_when_ordered || item['p']
    #   new_item['hamper_id']    = item.hamper_id || item['h']
    #   return new_item
    # end

    def set_hampers      
      if customer_signed_in? then
        @hampers = Hamper.where(:customer_id => current_customer[:id])
        @hampers.map do |hamper| 
          hamper[:price] = get_hamper_price(hamper.hamper_items)
          # hamper[:hamper_items] = add_product_names(hamper.hamper_items)
          return hamper
        end
      else
        @hampers = [create_session_hamper]
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_hamper
        @hamper = (params[:id].to_i == 0) ? create_session_hamper : load_db_hamper
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hamper_params
      params.require(:hamper).permit(:customer_id, :name, :price, :greeting)
    end
end
