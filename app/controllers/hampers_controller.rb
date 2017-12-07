class HampersController < ApplicationController
  before_action :set_hamper, only: [:show, :edit, :update, :destroy]

  # GET /hampers
  # GET /hampers.json
  def index
    @hampers = Hamper.all
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
    # Use callbacks to share common setup or constraints between actions.
    def set_hamper
      if(params[:id].to_i == 0) then
        @hamper = {customer_id:0, name: "My Hamper", price: 0, greeting:"", hamper_items: session['hamper0']}
      end 
      @hamper = Hamper.find(params[:id]) if(params[:id].to_i > 0)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hamper_params
      params.require(:hamper).permit(:customer_id, :name, :price, :greeting)
    end
end
