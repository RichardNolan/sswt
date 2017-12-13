class ProductsController < ApplicationController

  # Check that Producer is logged in
  before_action :authenticate_producer!, only: [:new, :edit, :update, :destroy]

  # Check if producer is disabled by admin
  before_action :producer_enabled, only: [:new, :edit, :update, :destroy]

  # set @product variable
  before_action :set_product, only: [:show, :edit, :update, :destroy]


  # Search by keyword
  def search
    
    # sanitize to prevent SQL Injection
    @keyword = ActionController::Base.helpers.sanitize(params[:query]) if params[:query]
    
    if @keyword
      @products = Product.where('(name LIKE ? OR description LIKE ?) AND enabled = ?', "%#{@keyword}%", "%#{@keyword}%", true)
    else
      @products = Product.where('enabled = ?', true)
    end

    # render products page
    render template: 'products/index'
  end

  
  def like
    # if the customer is signed in
    if customer_signed_in? then
      # create a new ProductLike object passing the id of the customer and the product
      ProductLike.create({customer_id: current_customer.id.to_i, product_id: params[:id].to_i})
    end
    # redirect back to where you've come from, any problems go to the product path
    redirect_back fallback_location: product_path
  end

  # GET /products
  # GET /products.json
  def index
    @products = Product.order('id DESC').where('enabled = ?',true)
  end

  # GET /products/1
  # GET /products/1.json
  def show
    # Show more products from Producer
    @more_products = @product.producer.products.order('id DESC').limit(4).where('enabled = ?',true)

    # if product is disallowed, redirect to main products page
    if @product.enabled == false
      redirect_to products_path
    end

  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Private methods -------------------------------------

  private  


    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(  :query,
                                        :producer_id, 
                                        :name, 
                                        :description, 
                                        :price, 
                                        :deleted, 
                                        :enabled, 
                                        :admin_notes, 
                                        :discount, 
                                        :min_quantity, 
                                        :start_date, 
                                        :end_date, 
                                        :contains_cerials, 
                                        :contains_crustaceans, 
                                        :contains_eggs, 
                                        :contains_fish, 
                                        :contains_peanuts, 
                                        :contains_soybeans, 
                                        :contains_milk, 
                                        :contains_nuts, 
                                        :contains_celery, 
                                        :contains_mustard, 
                                        :contains_semsame, 
                                        :contains_sulphur, 
                                        :contains_lupin, 
                                        :contains_mullucus,
                                        category_ids:[]
                                      )
    end
end
