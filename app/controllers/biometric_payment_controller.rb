class BiometricPaymentController < ApplicationController
  before_action :authenticate_user!
  
  def show
    current_user.set_payment_processor :stripe
    current_user.payment_processor.customer 

    @checkout_session = current_user
      .payment_processor
      .checkout(
        mode: 'payment',
        line_items: 'price_1LViZKA4TChht1jzuFctq5e1',
        success_url: biometic_payment_success_user_will_url
      )
  end

  def success
  end

  def cancel

end
