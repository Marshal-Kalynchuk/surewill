class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  auto_session_timeout 5.minutes

  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :set_no_cache

  def set_no_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:password, :password_confirmation, :current_password)}
  end
end
