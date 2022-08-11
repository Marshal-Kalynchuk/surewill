class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = current_user
    payment_processor = current_user.payment_processor
    if payment_processor
      @portal_session = payment_processor.billing_portal
    end
  end
end
