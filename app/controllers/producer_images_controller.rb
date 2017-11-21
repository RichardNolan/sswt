class ProducerImagesController < ApplicationController
  before_action :set_producer_image, only: [:show, :edit, :update, :destroy]

  # GET /producer_images
  # GET /producer_images.json
  def index
    @producer_images = ProducerImage.all
  end

  # GET /producer_images/1
  # GET /producer_images/1.json
  def show
  end

  # GET /producer_images/new
  def new
    @producer_image = ProducerImage.new
  end

  # GET /producer_images/1/edit
  def edit
  end

  # POST /producer_images
  # POST /producer_images.json
  def create
    @producer_image = ProducerImage.new(producer_image_params)

    respond_to do |format|
      if @producer_image.save
        format.html { redirect_to @producer_image, notice: 'Producer image was successfully created.' }
        format.json { render :show, status: :created, location: @producer_image }
      else
        format.html { render :new }
        format.json { render json: @producer_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /producer_images/1
  # PATCH/PUT /producer_images/1.json
  def update
    respond_to do |format|
      if @producer_image.update(producer_image_params)
        format.html { redirect_to @producer_image, notice: 'Producer image was successfully updated.' }
        format.json { render :show, status: :ok, location: @producer_image }
      else
        format.html { render :edit }
        format.json { render json: @producer_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /producer_images/1
  # DELETE /producer_images/1.json
  def destroy
    @producer_image.destroy
    respond_to do |format|
      format.html { redirect_to producer_images_url, notice: 'Producer image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_producer_image
      @producer_image = ProducerImage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def producer_image_params
      params.require(:producer_image).permit(:producer_id, :src, :primary_image)
    end
end
