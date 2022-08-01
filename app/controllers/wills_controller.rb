class WillsController < ApplicationController
  before_action :authenticate_user!, :set_will, only: %i[ show edit update destroy ]

  # GET /wills or /wills.json
  def index
    @wills = Will.all
  end

  # GET /wills/1 or /wills/1.json
  def show
  end

  # GET /wills/new
  def new
    @will = Will.new
  end

  # GET /wills/1/edit
  def edit
  end

  # POST /wills or /wills.json
  def create
    @will = Will.new(will_params)

    respond_to do |format|
      if @will.save
        format.html { redirect_to will_url(@will), notice: "Will was successfully created." }
        format.json { render :show, status: :created, location: @will }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @will.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wills/1 or /wills/1.json
  def update
    respond_to do |format|
      if @will.update(will_params)
        format.html { redirect_to will_url(@will), notice: "Will was successfully updated." }
        format.json { render :show, status: :ok, location: @will }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @will.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wills/1 or /wills/1.json
  def destroy
    @will.destroy

    respond_to do |format|
      format.html { redirect_to wills_url, notice: "Will was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_will
      @will = Will.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def will_params
      params.require(:will).permit(:user_id, :status, :prepaid)
    end
end
