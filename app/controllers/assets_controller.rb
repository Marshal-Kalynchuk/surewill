class AssetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_will
  before_action :set_asset, only: %i[ show edit update destroy ]
  layout "dashboard"

  # GET /assets or /assets.json
  def index
    @assets = @will.assets.preload(:primary_beneficiaries).preload(:secondary_beneficiaries).preload(:address)
  end

  # GET /assets/1 or /assets/1.json
  def show
  end

  # GET /assets/new
  def new
    @asset = @will.assets.build
    @asset.build_address
    @delegates = @will.delegates
  end

  # GET /assets/1/edit
  def edit
    @delegates = @will.delegates
  end

  # POST /assets or /assets.json
  def create
    @asset = @will.assets.build(asset_params)

    respond_to do |format|
      if @asset.save
        @size = @will.assets.size
        format.turbo_stream
        format.html { redirect_to user_will_assets_path(current_user), notice: "asset was successfully created." }
        format.json { render :show, status: :created, location: @asset }
      else
        @delegates = @will.delegates
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
        format.html { redirect_to user_will_assets_path(current_user), notice: "asset was successfully updated." }
        format.json { render :show, status: :ok, location: @asset }
      else
        @delegates = @will.delegates
        format.turbo_stream { render turbo_stream: turbo_stream.replace("asset_#{@asset.id}_form", partial: "form", locals: { asset: @asset }), status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1 or /assets/1.json
  def destroy
    @asset.destroy
    @size = @will.assets.size

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to assets_url, notice: "asset was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_will
      @will = current_user.will
      redirect_to :root if @will.nil?
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_asset
      @asset = @will.assets.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def asset_params
      params.require(:asset).permit(
        :id, :asset_type, :title, 
        address_attributes: [ :id, :line_1, :line_2, :city, :zone, :postal_code, :country_code ],
        primary_bequests_attributes: [ :primary, :beneficiariable_id, :beneficiariable_type, :percentage, :id, :_destroy ],
        secondary_bequests_attributes: [ :primary, :beneficiariable_id, :beneficiariable_type, :percentage, :id, :_destroy ]
      )
    end
end
