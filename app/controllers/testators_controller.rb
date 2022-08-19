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
  end

  # GET /testators/1/edit
  def edit
  end

  # POST /testators or /testators.json
  def create
    @testator = @will.build_testator(testator_params)

    respond_to do |format|
      if @testator.save
        format.html { redirect_to user_will_testator_url(current_user, @testator), notice: "Testator was successfully created." }
        format.json { render :show, status: :created, location: @testator }
        format.turbo_stream
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @testator.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /testators/1 or /testators/1.json
  def update
    respond_to do |format|
      if @testator.update(testator_params)
        format.html { redirect_to user_will_testator_url(current_user, @testator), notice: "Testator was successfully updated." }
        format.json { render :show, status: :ok, location: @testator }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @testator.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /testators/1 or /testators/1.json
  def destroy
    @testator.destroy

    respond_to do |format|
      format.html { redirect_to testators_url, notice: "Testator was successfully destroyed." }
      format.json { head :no_content }
      format.turbo_stream
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
      @will ? true : false
    end

    # Only allow a list of trusted parameters through.
    def testator_params
      params.require(:testator).permit(
        :id, :_destroy,
        :first_name, :middle_name, :last_name, 
      )
    end
end
