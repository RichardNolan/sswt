class CategoriesController < ApplicationController
  
  # Only Admin can create, edit, delete, enable or disable
  before_action :authenticate_admin!, only: [:new, :edit, :update, :destroy]

  # Set @category variable
  before_action :set_category, only: [:show, :edit, :update, :destroy]


  # Main Categories page
  def index
    
  end


  # Display Products by Category
  def show
    @products = @category.products.where('enabled = ?', true) # only enabled products
    render template: "products/index"
  end


  # Create new category
  def new
    @category = Category.new
  end


  # Edit Category
  def edit
  end


  # Form post new category
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, notice: 'Category was successfully created.'
    else
      render :new
    end
  end


  # Form update category
  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end


  # Delete Category
  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end


  # Private methods -------------------------------------
  private

    # Set @category variable
    def set_category
      @category = Category.find(params[:id])
    end

    # Permitted parameters
    def category_params
      params.require(:category).permit(:name, :description, :image)
    end

end
