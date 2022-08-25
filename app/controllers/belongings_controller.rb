class BelongingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_will
  before_action :set_belonging, only: %i[ show edit update destroy ]

  # GET /belongings or /belongings.json
  def index
    @belongings = @will.belongings.preload(:primary_beneficiaries)
  end

  # GET /belongings/1 or /belongings/1.json
  def show
  end

  # GET /belongings/new
  def new
    @belonging = @will.belongings.build
    @delegates = @will.delegates
  end

  # GET /belongings/1/edit
  def edit
    @delegates = @will.delegates
  end

  # POST /belongings or /belongings.json
  def create
    @belonging = @will.belongings.build(belonging_params)

    respond_to do |format|
      if @belonging.save
        @size = @will.properties.size
        format.turbo_stream
        format.html { redirect_to belonging_url(@belonging), notice: "Belonging was successfully created." }
        format.json { render :show, status: :created, location: @belonging }
      else
        @delegates = @will.delegates
        format.turbo_stream { render turbo_stream: turbo_stream.replace("property_#{@property.id}_form", partial: "form", locals: { property: @property }), status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @belonging.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /belongings/1 or /belongings/1.json
  def update
    respond_to do |format|
      if @belonging.update(belonging_params)
        format.turbo_stream
        format.html { redirect_to belonging_url(@belonging), notice: "Belonging was successfully updated." }
        format.json { render :show, status: :ok, location: @belonging }
      else
        @delegates = @will.delegates
        format.turbo_stream { render turbo_stream: turbo_stream.replace("property_#{@property.id}_form", partial: "form", locals: { property: @property }), status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @belonging.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /belongings/1 or /belongings/1.json
  def destroy
    @belonging.destroy
    @size = @will.belongings.size

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to belongings_url, notice: "Belonging was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_will
      @will = current_user.will
      redirect_to :root if @will.nil?
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_belonging
      @belonging = @will.belongings.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def belonging_params
      params.require(:belonging).permit(
        :id, :title, :description,
        primary_bequests_attributes: [ :primary, :beneficiariable_id, :beneficiariable_type, :percentage, :id, :_destroy ],)
    end
end
