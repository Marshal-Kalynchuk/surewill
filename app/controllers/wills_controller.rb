class WillsController < ApplicationController
  before_action :authenticate_user!#, except: %i[ new ]
  before_action :set_will, only: %i[ show update destroy ]

  # GET /wills or /wills.json
  def index
    @wills = Will.all
  end

  # GET /wills/1 or /wills/1.json
  def show
  end

  # GET /wills/new
  def new
    if user_signed_in? && current_user.will
      redirect_to edit_will_path(current_user)
    end
    @will = Will.new
    @will.assets.build
    @will.accessors.build
  end

  # GET /wills/1/edit
  def edit
    redirect_to new_will_path unless current_user.will
    @will = current_user.will
    @will.assets.build unless @will.assets
    @will.accessors.build unless @will.accessors
  end

  # POST /wills or /wills.json
  def create
    if user_signed_in? && current_user.will
      redirect_to edit_will_path(current_user.will)
    else
      @will = current_user.build_will(will_params)
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
      @beneficiaries = @will.beneficiaries
      @assets = @will.assets 
      @accessors = @will.accessors
    end

    # Only allow a list of trusted parameters through.
    def will_params
      params.require(:will).permit(
        :testator, :user_id, :public, :prepaid,
      assets_attributes: [ :title, :description, :image, :id ],
      accessors_attributes: [ :name, :email, :accessor_type, :id ]
    )
    end
end
