# Authenticatable
# Setup for the CAS Authentication.
module Authenticatable
  extend ActiveSupport::Concern
  include AuthenticationHelper

  # Performs a login request to the cas server.
  # @author David J. Davis
  # @return No return value.
  def login
    if authenticated?
      # User is already authenticated, redirect to home or stored location
      default_path = admin? ? admin_path : root_path
      redirect_to session[:return_to] || default_path, success: I18n.t('auth.success')
      session.delete(:return_to) # Clean up after successful redirect
    else
      # Special development mode handling
      if Rails.env.development?
        # Store location for return after auth
        session[:return_to] = request.referer || admin_path
        
        # Directly access CAS server instead of returning 401
        # Add allow_other_host: true to bypass Rails 7 host checking
        redirect_to "#{Rails.application.config_for(:application)["cas_url"]}login?service=#{CGI.escape(request.base_url + '/login')}", allow_other_host: true
      else
        # In production, let Rack::CAS handle it via 401
        render(plain: 'Unauthorized!', status: :unauthorized)
      end
    end
  end

  # Performs a logout request and resets the current session.
  # @author David J. Davis
  # @return No return value.
  def logout
    reset_session
    redirect_to root_path, success: I18n.t('auth.log_out')
  end
  alias signout logout
end
