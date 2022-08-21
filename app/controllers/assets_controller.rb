class AssetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_will
  before_action :set_asset, only: %i[ show edit update destroy ]
  layout "dashboard"

  # GET /assets or /assets.json
  def index
  end

  # GET /assets/1 or /assets/1.json
  def show
  end

  # GET /assets/new
  def new
    @asset = @assets.build
    @delegate = @asset.bequests.build
  end

  # GET /assets/1/edit
  def edit
  end

  # POST /assets or /assets.json
  def create
    @asset = @assets.build(asset_params)

    respond_to do |format|
      if @asset.save
        format.turbo_stream
        format.html { redirect_to user_will_assets_path(current_user), notice: "Asset was successfully created." }
        format.json { render :show, status: :created, location: @asset }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_asset_form", partial: "form", locals: { asset: @asset }), status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assets/1 or /assets/1.json
  def update
    respond_to do |format|
      if @asset.update(asset_params)
        format.turbo_stream
        format.html { redirect_to user_will_assets_path(current_user), notice: "Asset was successfully updated." }
        format.json { render :show, status: :ok, location: @asset }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("asset_#{@asset.id}_form", partial: "form", locals: { asset: @asset }), status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1 or /assets/1.json
  def destroy
    @asset.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to assets_url, notice: "Asset was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_will
      @will = current_user.will
      redirect_to :root if @will.nil?
      @delegates = @will.delegates
      @assets = @will.assets
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_asset
      @asset = @assets.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_params
      params.require(:asset).permit(
        :id, :asset_type, :title, :description, 
        bequests_attributes: [ :beneficiariable_id, :beneficiariable_type, :percentage, :id ]
      )
    end
end
