class PrepayController < ApplicationController
  before_action :authenticate_user!
  before_action :validate_will

  def show
    current_user.set_payment_processor :stripe
    current_user.payment_processor.customer 

    @checkout_session = current_user
      .payment_processor
      .checkout(
        mode: 'payment',
        line_items: 'price_1LVN8nA4TChht1jz8YnUS17Y',
        success_url: prepay_success_url
      )

  end

  def success
    current_user.will.prepaid = true 
    current_user.will.save
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @line_items = Stripe::Checkout::Session.list_line_items([params[:session_id]])
  end

  def failular

  end

  private
  def validate_will
    unless current_user.will && !current_user.will.prepaid
      redirect_to new_user_will_path(current_user)
    end
  end

end
