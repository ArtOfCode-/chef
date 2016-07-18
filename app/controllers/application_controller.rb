class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception, prepend: true
  before_action :configure_parameters, if: :devise_controller?

  private
    def configure_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end
end
