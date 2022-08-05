class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @subscriptions = current_user.subscriptions
  end

  def show
    @subscription = current_user.subscriptions.find(params[:id])
  end

  private
  def subscription_params
    params.require(:subscription).permit(:id)
  end

end
