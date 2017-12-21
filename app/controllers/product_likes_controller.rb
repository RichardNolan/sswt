class ProductLikesController < ApplicationController
  before_action :set_product_like, only: [:show, :edit, :update, :destroy]

  # GET /product_likes
  # GET /product_likes.json
  def index
    redirect_to :root, notice: 'There\'s nothing to see at the URL entered.'
    @product_likes = ProductLike.all
  end

  # GET /product_likes/1
  # GET /product_likes/1.json
  def show
    redirect_to :root, notice: 'There\'s nothing to see at the URL entered.'
  end

  # GET /product_likes/new
  def new
    redirect_to :root, notice: 'There\'s nothing to see at the URL entered.'
    @product_like = ProductLike.new
  end

  # GET /product_likes/1/edit
  def edit
    redirect_to :root, notice: 'There\'s nothing to see at the URL entered.'
  end

  # POST /product_likes
  # POST /product_likes.json
  def create
    @product_like = ProductLike.new(product_like_params)

    respond_to do |format|
      if @product_like.save
        format.html { redirect_to @product_like, notice: 'Product like was successfully created.' }
        format.json { render :show, status: :created, location: @product_like }
      else
        format.html { render :new }
        format.json { render json: @product_like.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_likes/1
  # PATCH/PUT /product_likes/1.json
  def update
    respond_to do |format|
      if @product_like.update(product_like_params)
        format.html { redirect_to @product_like, notice: 'Product like was successfully updated.' }
        format.json { render :show, status: :ok, location: @product_like }
      else
        format.html { render :edit }
        format.json { render json: @product_like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_likes/1
  # DELETE /product_likes/1.json
  def destroy
    @product_like.destroy
    respond_to do |format|
      format.html { redirect_to product_likes_url, notice: 'Product like was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_like
      @product_like = ProductLike.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_like_params
      params.require(:product_like).permit(:product_id, :customer_id)
    end
end
