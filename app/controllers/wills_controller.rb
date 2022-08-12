class WillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_will, except: [ :index, :new, :create ]

  before_action :authenticate_testator, only: [ :edit, :update ]
  before_action :authenticate_current_beneficiary, only: [ :release ]

  # GET /wills or /wills.json
  def index
    beneficiaries = Beneficiary.where(email: current_user.email)
    if beneficiaries
      @wills = beneficiaries.collect{ |beneficiary| beneficiary.will }
    end
  end

  # GET /wills/1 or /wills/1.json
  def show
    if @current_beneficiary
      if @will.released?
        if current_user.accessors.find_by(will: @will)
          render :show
        else
          redirect_to access_user_will_url(@will.user_id, @will.id)
        end
      else
        render :not_released
      end
    elsif @will == current_user.will
      render :show
    else
      redirect_to not_found_path
    end
  end

  # GET /wills/new
  def new
    unless current_user.will
      @will = Will.new
      @will.assets.build
      @will.beneficiaries.build
    else 
      redirect_to edit_user_will_path(current_user, current_user.will) 
    end
  end

  # GET /wills/1/edit
  def edit
    if current_user.will
      @will = current_user.will
      @will.assets.build unless @will.assets
      @will.beneficiaries.build unless @will.beneficiaries
    else
      redirect_to new_user_will_path(current_user) 
    end
  end

  # POST /wills or /wills.json
  def create
    unless current_user.will
      @will = current_user.build_will(will_params)
      respond_to do |format|
        if @will.save
          format.html { redirect_to prepay_user_will_url(current_user), notice: "Will was successfully created." }
          format.json { render :show, status: :created, location: @will }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @will.errors, status: :unprocessable_entity }
        end
      end
    else 
      redirect_to edit_user_will_path(current_user.will) 
    end
  end

  # PATCH/PUT /wills/1 or /wills/1.json
  def update
    respond_to do |format|
      if @will.update(will_params)
        if @will.prepaid
          format.html { redirect_to user_will_url(current_user, @will), notice: "Will was successfully updated." }
          format.json { render :show, status: :ok, location: @will }
        else
          format.html { redirect_to prepay_user_will_url(current_user, @will), notice: "Will was successfully updated." }
        end
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

  def release
    if @current_beneficiary.can_release
      @will.release_user_will(@current_beneficiary)
      if @will.save
        redirect_to user_will_path(@will.user, @will)
      else
        flash[:alert] = "An error occurred"
        redirect_to :root
      end
    else
      flash[:alert] = "You are not permitted to release this will!"
      redirect_to :root
    end
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_will
      @will = User.find(params[:user_id]).will
      @assets = @will.assets 
      @beneficiaries = @will.beneficiaries
      @current_beneficiary = @will.beneficiaries.find_by(email: current_user.email)
    end

    def authenticate_testator
      current_user.will == @will
    end

    def authenticate_current_beneficiary
      @current_beneficiary
    end

    # Only allow a list of trusted parameters through.
    def will_params
      params.require(:will).permit(
        :testator, :user_id, :public, :released,
      assets_attributes: [ :title, :description, :image, :id ],
      beneficiaries_attributes: [ :name, :email, :role, :can_release, :id ]
      )
    end

end
