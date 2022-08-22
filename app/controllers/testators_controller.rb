class TestatorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_will
  before_action :set_testator, only: %i[ show edit update destroy ]
  layout "dashboard"

  # GET /testators/1 or /testators/1.json
  def show
  end

  # GET /testators/new
  def new
    @testator = @will.build_testator
    @testator.build_address
  end

  # GET /testators/1/edit
  def edit
  end

  # POST /testators or /testators.json
  def create
    @testator = @will.build_testator(testator_params)

    respond_to do |format|
      if @testator.save
        format.turbo_stream
        format.html { redirect_to user_will_testator_url(current_user, @testator), notice: "Testator was successfully created." }
        format.json { render :show, status: :created, location: @testator }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_testator_form", partial: "form", locals: { testator: @testator }), status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @testator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /testators/1 or /testators/1.json
  def update
    respond_to do |format|
      if @testator.update(testator_params)
        format.turbo_stream
        format.html { redirect_to user_will_testator_url(current_user, @testator), notice: "Testator was successfully updated." }
        format.json { render :show, status: :ok, location: @testator }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("testator_#{@testator.id}_form", partial: "form", locals: { testator: @testator }), status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @testator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /testators/1 or /testators/1.json
  def destroy
    @testator.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to testators_url, notice: "Testator was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_testator
      @testator = @will.testator
      redirect_to new_user_will_testator_path(current_user) unless @testator
    end

    def set_will
      @will = current_user.will
      redirect_to :root if @will.nil?
    end

    # Only allow a list of trusted parameters through.
    def testator_params
      params.require(:testator).permit(
        :id, :_destroy,
        :first_name, :middle_name, :last_name, 
        address_attributes: [:id, :line_1, :line_2, :city, :region, :postal_code, :country, :country_code ]
      )
    end
end
