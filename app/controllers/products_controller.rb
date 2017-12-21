class ProductsController < ApplicationController

  # Check that Producer is logged in (only if user is not admin)
  before_action :check_permission, only: [:new, :edit, :update, :destroy]

  # Only admin can disable/enable products
  before_action :authenticate_admin!, only: [:enable, :disable]
  
  # set @product variable
  before_action :set_product, only: [:show, :edit, :update, :destroy, :enable, :disable, :like, :undelete]

  # set where images are needed
  before_action :set_images, only: [:show, :edit]

  # Check that Producer is owner of Product (unless user is admin)
  before_action :is_owner, only: [:edit, :update, :destroy]

  # Redirect if product is disabled (unless user is admin)
  before_action :redirect_if_product_disabled, only: [:show]


  # Search by keyword
  def search
    
    # sanitize to prevent SQL Injection
    @keyword = ActionController::Base.helpers.sanitize(params[:query]) if params[:query]
    
    if @keyword
      @products = Product.where('(name ILIKE ? OR description ILIKE ?) AND enabled = ? AND deleted = ?', "%#{@keyword}%", "%#{@keyword}%", true, false)
    else
      @products = Product.where('enabled = ?', true)
    end
    
  
    @total_products = @products.count
    @offset = params[:offset].to_i || 0
    @offset = 0 if @offset < 0 

    @url = "/products/"
    @products = @products
                  .limit(4)
                  .offset(@offset)

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
    # redirect_back fallback_location: product_path
    render json: @product
  end


  # Main Products page
  def index
    @products = Product
                  .order('id DESC')
                  .where('enabled = ? AND deleted = ?',true, false)

    @total_products = @products.count
    @offset = params[:offset].to_i || 0
    @offset = 0 if @offset < 0 

    @url = "/products/"
    @products = @products
                  .limit(4)
                  .offset(@offset)
  end


  # Show Product Page
  def show
    
    # More products from Producer
    @more_products = @product.producer.products.order('id DESC').where('enabled = ? AND id <> ? AND deleted = ?',true, @product.id, false)

    # Allergen details
    @allergens = getAllergens

  end


  # Upload new product
  def new
    @product = Product.new
    @product.product_images.build
    @form_submit_button = 'Upload Product'
    @producer_id = current_producer.id
  end


  # Edit Product
  def edit
    @product.product_images.build
    @form_submit_button = 'Save Product'
    @producer_id = @product.producer_id
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
    #puts '#############################'
    #puts product_params
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end


  # Delete Product
  def destroy
    # only updates "deleted" field to true, instead of actually deleting the product from the database
    @product.deleted = true
    @product.save
    redirect_to @product, notice: 'Product was successfully deleted.'
  end


  # Un-Delete Product
  def undelete
    # updates "deleted" field to false
    @product.deleted = false
    @product.save
    redirect_to @product, notice: 'Product was successfully reactivated.'
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

    def set_images      
      # get images with this product id
      @images = ProductImage.where('product_id = ?', @product.id)
    end

    # Producer is owner of product
    def is_owner
      if !admin_signed_in?  
        redirect_to @product if not @product.producer_id == current_producer.id
      end
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
                                        category_ids:[], 
                                        product_images_attributes:[:src, :id, :primary_image]
                                      )
    end


    # if product is disallowed, redirect to main products page (admin allowed to see)
    def redirect_if_product_disabled 
      if @product.enabled == false && !admin_signed_in?
        redirect_to products_path
      end
    end


    # Check permission to edit
    def check_permission
      if !producer_signed_in? && !admin_signed_in?
        redirect_to new_producer_session_path
      end
    end


    # Get Allergen Details
    def getAllergens

      # selected allergens
      selected_allergens = []

      selected_allergens << "Cerials" if @product.contains_cerials == true
      selected_allergens << "Crustaceans" if @product.contains_crustaceans == true
      selected_allergens << "Eggs" if @product.contains_eggs == true
      selected_allergens << "Fish" if @product.contains_fish == true
      selected_allergens << "Peanuts" if @product.contains_peanuts == true
      selected_allergens << "Soybeans" if @product.contains_soybeans == true
      selected_allergens << "Milk" if @product.contains_milk == true
      selected_allergens << "Nuts" if @product.contains_nuts == true
      selected_allergens << "Celery" if @product.contains_celery == true
      selected_allergens << "Mustard" if @product.contains_mustard == true
      selected_allergens << "Sesame" if @product.contains_semsame == true
      selected_allergens << "Sulphur" if @product.contains_sulphur == true
      selected_allergens << "Lupin" if @product.contains_lupin == true
      selected_allergens << "Mullucus" if @product.contains_mullucus == true

      return selected_allergens

    end
end
