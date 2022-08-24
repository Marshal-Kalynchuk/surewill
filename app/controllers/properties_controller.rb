class PropertiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_will
  before_action :set_property, only: %i[ show edit update destroy ]
  layout "dashboard"

  # GET /properties or /properties.json
  def index
    @properties = @will.properties
    @properties.each do |property| 
      property.primary_valid?
      property.secondary_valid?
    end
  end

  # GET /properties/1 or /properties/1.json
  def show
  end

  # GET /properties/new
  def new
    @property = @will.properties.build
    @property.build_address
    @delegates = @will.delegates
  end

  # GET /properties/1/edit
  def edit
    @delegates = @will.delegates
  end

  # POST /properties or /properties.json
  def create
    @property = @will.properties.build(property_params)

    respond_to do |format|
      if @property.save
        format.turbo_stream
        format.html { redirect_to user_will_properties_path(current_user), notice: "property was successfully created." }
        format.json { render :show, status: :created, location: @property }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_property_form", partial: "form", locals: { property: @property }), status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1 or /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.turbo_stream
        format.html { redirect_to user_will_properties_path(current_user), notice: "property was successfully updated." }
        format.json { render :show, status: :ok, location: @property }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("property_#{@property.id}_form", partial: "form", locals: { property: @property }), status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1 or /properties/1.json
  def destroy
    @property.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to properties_url, notice: "property was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_will
      @will = current_user.will
      redirect_to :root if @will.nil?
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = @will.properties.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def property_params
      params.require(:property).permit(
        :id, :property_type, :title, 
        address_attributes: [ :id, :line_1, :line_2, :city, :zone, :postal_code, :country_code ],
        primary_bequests_attributes: [ :primary, :beneficiariable_id, :beneficiariable_type, :percentage, :id, :_destroy ],
        secondary_bequests_attributes: [ :primary, :beneficiariable_id, :beneficiariable_type, :percentage, :id, :_destroy ]
      )
    end
end
