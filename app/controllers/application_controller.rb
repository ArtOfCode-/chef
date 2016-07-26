class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception, prepend: true
  before_action :configure_parameters, if: :devise_controller?
  before_action :authorize_profiler

  protected
    def api_has_more(page, pagesize, count)
      page ||= 1
      return count > page * pagesize
    end

  private
    def configure_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
      devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end

    def authorize_profiler
      if user_signed_in? && current_user.is_admin
        Rack::MiniProfiler.authorize_request
      end
    end
end
