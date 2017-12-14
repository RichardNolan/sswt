class ProductsController < ApplicationController

  # Check that Producer is logged in
  before_action :authenticate_producer!, only: [:new, :edit, :update, :destroy]

  # Only admin can disable/enable products
  before_action :authenticate_admin!, only: [:enable, :disable]
  
  # Check if producer is disabled by admin
  before_action :producer_enabled, only: [:new, :edit, :update, :destroy]

  # set @product variable
  before_action :set_product, only: [:show, :edit, :update, :destroy, :enable, :disable]

  # Check that Producer is owner of Product
  before_action :is_owner, only: [:edit, :update, :destroy]

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

  
  # Customer Likes Product  
  def like
    # if the customer is signed in
    if customer_signed_in? then
      # create a new ProductLike object passing the id of the customer and the product
      ProductLike.create({customer_id: current_customer.id.to_i, product_id: params[:id].to_i})
    end
    # redirect back to where you've come from, any problems go to the product path
    redirect_back fallback_location: product_path
  end


  # Main Products page
  def index
    @products = Product.order('id DESC').where('enabled = ?',true)
  end


  # Show Product Page
  def show
    
    # if product is disallowed, redirect to main products page (admin allowed to see)
    if @product.enabled == false && !admin_signed_in?
      redirect_to products_path
    end

    # More products from Producer
    @more_products = @product.producer.products.order('id DESC').limit(4).where('enabled = ?',true)

  end


  # Upload new product
  def new
    @product = Product.new
  end


  # Edit Product
  def edit
  end


  # Form submission for new product
  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new        
    end
  end


  # Form submission for update product
  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end


  # Delete Product
  def destroy
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end


  # Disable Product (admin)
  def disable
    @product.enabled = false
    @product.save
    redirect_to @product
  end


  # Enable Product (admin)
  def enable
    @product.enabled = true
    @product.save
    redirect_to @product
  end


  # Private methods -------------------------------------
  private  


    # Producer is owner of product
    def is_owner
      redirect_to @product if not @product.producer_id == current_producer.id
    end

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
