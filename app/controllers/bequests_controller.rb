class BequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_will
  before_action :set_bequest, only: %i[ show edit update destroy ]

  # GET /bequests or /bequests.json
  def index
    @bequests = @will.bequests
  end

  # GET /bequests/1 or /bequests/1.json
  def show
  end

  # GET /bequests/new
  def new
    @bequest = @will.bequests.build
  end

  # GET /bequests/1/edit
  def edit
  end

  # POST /bequests or /bequests.json
  def create
    @bequest = @will.bequests.build(bequest_params)

    respond_to do |format|
      if @bequest.save
        format.html { redirect_to bequest_url(@bequest), notice: "Bequest was successfully created." }
        format.json { render :show, status: :created, location: @bequest }
        format.turbo_stream { render :show, status: :created, location: @bequest }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bequest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bequests/1 or /bequests/1.json
  def update
    respond_to do |format|
      if @bequest.update(bequest_params)
        format.html { redirect_to bequest_url(@bequest), notice: "Bequest was successfully updated." }
        format.json { render :show, status: :ok, location: @bequest }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bequest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bequests/1 or /bequests/1.json
  def destroy
    @bequest.destroy

    respond_to do |format|
      format.html { redirect_to bequests_url, notice: "Bequest was successfully destroyed." }
      format.json { head :no_content }
      format.turbo_stream { render :destroy, status: :ok, location: @bequest }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_will
      @will = current_user.will
      @will ? true : false
    end

    def set_bequest
      @bequest = current_user.bequests.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bequest_params
      params.require(:bequest).permit(:id, :_destroy, :will_id, :beneficiary_id, :percentage)
    end
end
