class WillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_will, except: [ :new, :create ]
  layout "dashboard"

  # before_action :authenticate_testator, only: [ :edit, :update ]
  # before_action :authenticate_current_beneficiary, only: [ :release ]

  # GET /wills or /wills.json
  # def index
  #   beneficiaries = Beneficiary.where(email: current_user.email)
  #   if beneficiaries
  #     @wills = beneficiaries.collect{ |beneficiary| beneficiary.will }
  #   end
  # end

  # GET /wills/1 or /wills/1.json
  def show
    if @will.prepaid
      current_user.set_payment_processor :stripe
      current_user.payment_processor.customer 

      @checkout_session = current_user
        .payment_processor
        .checkout(
          mode: 'payment',
          line_items: 'price_1LVN8nA4TChht1jz8YnUS17Y',
          success_url: prepay_success_user_will_url
        )
    end
    respond_to do |format|
      format.html { render :show }
      format.json { render :show }
      format.pdf do
        pdf = WillDocument.new(@will, @testator, @delegates, @assets)
        send_data pdf.render, filename: "last_will_and_testament.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  def pdf
  end

  # GET /wills/new
  def new
    unless current_user.will
      @will = current_user.build_will
      @testator = @will.build_testator
    else
      redirect_to user_will_build_index_path(current_user)
    end
  end

  # GET /wills/1/edit
  def edit
    redirect_to user_will_build_index_path(current_user)
  end

  # POST /wills or /wills.json
  def create
    @will = current_user.build_will(will_params)
    respond_to do |format|
      if @will.save
        format.html { redirect_to user_will_build_index_path(current_user), notice: "Will was successfully created." }
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

  # def release
  #   if @current_beneficiary.can_release
  #     @will.release_user_will(@current_beneficiary)
  #     if @will.save
  #       redirect_to user_will_path(@will.user, @will)
  #     else
  #       flash[:alert] = "An error occurred"
  #       redirect_to :root
  #     end
  #   else
  #     flash[:alert] = "You are not permitted to release this will!"
  #     redirect_to :root
  #   end
  # end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_will
      @will = current_user.will
      redirect_to :root if @will.blank?
      @testator = @will.testator
      @assets = @will.assets 
      @delegates = @will.delegates
      @accessors = @will.accessors
    end

    # def authenticate_testator
    #   current_user.will == @will
    # end

    # def authenticate_current_beneficiary
    #   @current_beneficiary
    # end

    # Only allow a list of trusted parameters through.
    def will_params
      params.require(:will).permit(
      :user_id, testator_attributes: [ :first_name, :middle_name, :last_name ])
    end

end
