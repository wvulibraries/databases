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
      redirect_to root_path, success: I18n.t('auth.success')
    else 
      render(plain: 'Unauthorized!', status: :unauthorized)
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
