class HamperItemsController < ApplicationController
  before_action :set_hamper_item, only: [:show, :edit, :update, :destroy]

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
