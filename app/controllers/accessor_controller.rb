class AccessorController < ApplicationController
  before_action :authenticate_user!
  before_action :set_will, :check_released, :authenticate_current_beneficiary
  before_action :check_user_accessor, :apply_prepay
  

  def show
    current_user.set_payment_processor :stripe
    current_user.payment_processor.customer 

    @checkout_session = current_user
      .payment_processor
      .checkout(
        mode: 'payment',
        line_items: 'price_1LVSSAA4TChht1jzch70YIrn',
        success_url: user_will_access_success_url(@will.user, @will)
      )

  end

  def success
    current_user.accessors.create(will: @will)
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
  end

  def failure

  end

  private

  def check_released
    redirect_to user_will_path(@will.user, @will) unless @will.released?
  end

  def apply_prepay
    if @will.prepaid
      current_user.accessors.create(will: @will)
      redirect_to user_will_path(@will.user, @will)
    end
  end

  def set_will
    @will = Will.find(params[:will_id])
    render "wills/not_found" unless @will
    @current_beneficiary = @will.beneficiaries.find_by(email: current_user.email)
  end

  def authenticate_current_beneficiary
    @current_beneficiary
  end

  def check_user_accessor
    redirect_to user_will_path(@will.user, @will) if current_user.accessors.find_by(will: @will)
  end
  
end
