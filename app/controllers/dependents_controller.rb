class DependentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_will
  before_action :set_dependent, only: %i[ show edit update destroy ]
  layout "dashboard"

  # GET /dependents or /dependents.json
  def index
  end

  # GET /dependents/1 or /dependents/1.json
  def show
  end

  # GET /dependents/new
  def new
    @dependent = @dependents.build
  end

  # GET /dependents/1/edit
  def edit
  end

  # POST /dependents or /dependents.json
  def create
    @dependent = @dependents.build(dependent_params)

    respond_to do |format|
      if @dependent.save
        @size = @will.dependents.size
        format.turbo_stream
        format.html { redirect_to dependent_url(@dependent), notice: "Dependent was successfully created." }
        format.json { render :show, status: :created, location: @dependent }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_delegate_form", partial: "form", locals: { delegate: @delegate }), status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @dependent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dependents/1 or /dependents/1.json
  def update
    respond_to do |format|
      if @dependent.update(dependent_params)
        format.turbo_stream
        format.html { redirect_to dependent_url(@dependent), notice: "Dependent was successfully updated." }
        format.json { render :show, status: :ok, location: @dependent }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("delegate_#{@delegate.id}_form", partial: "form", locals: { delegate: @delegate }), status: :unprocessable_entity }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @dependent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dependents/1 or /dependents/1.json
  def destroy
    @dependent.destroy
    @size = @will.dependents.size

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to dependents_url, notice: "Dependent was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_will
      @will = current_user.will
      redirect_to :root if @will.nil?
      @dependents = @will.dependents
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_dependent
      @dependent = @dependents.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dependent_params
      params.require(:dependent).permit(
        :first_name, :last_name, :id, :_destroy
      )
    end
end
