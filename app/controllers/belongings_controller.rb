class BelongingsController < ApplicationController
  before_action :set_belonging, only: %i[ show edit update destroy ]

  # GET /belongings or /belongings.json
  def index
    @belongings = Belonging.all
  end

  # GET /belongings/1 or /belongings/1.json
  def show
  end

  # GET /belongings/new
  def new
    @belonging = Belonging.new
  end

  # GET /belongings/1/edit
  def edit
  end

  # POST /belongings or /belongings.json
  def create
    @belonging = Belonging.new(belonging_params)

    respond_to do |format|
      if @belonging.save
        format.html { redirect_to belonging_url(@belonging), notice: "Belonging was successfully created." }
        format.json { render :show, status: :created, location: @belonging }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @belonging.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /belongings/1 or /belongings/1.json
  def update
    respond_to do |format|
      if @belonging.update(belonging_params)
        format.html { redirect_to belonging_url(@belonging), notice: "Belonging was successfully updated." }
        format.json { render :show, status: :ok, location: @belonging }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @belonging.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /belongings/1 or /belongings/1.json
  def destroy
    @belonging.destroy

    respond_to do |format|
      format.html { redirect_to belongings_url, notice: "Belonging was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_belonging
      @belonging = Belonging.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def belonging_params
      params.require(:belonging).permit(:will_id, :title, :description)
    end
end
