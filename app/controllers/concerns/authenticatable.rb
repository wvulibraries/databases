# Authenticatable 
# Setup for the CAS Authentication.
module Authenticatable
  extend ActiveSupport::Concern

  # Creates a filter for accessing the admin panel. 
  # Redirects unauthenticated users to the root path.
  # @author David J. Davis
  # @return true
  def access_permissions
    return true if authenticated? && admin?
    redirect_to(root_path, error: access_feedback) && return
  end

  # Returns an error string back to access_permissions, 
  # to reduce logical complexity for rubocop. 
  # @author David J. Davis
  # @return true
  def access_feedback
    error_string = ''
    error_string << I18n.t('auth.invalid_access') unless authenticated?
    error_string << I18n.t('auth.invalid_permissions') unless admin?
    error_string
  end

  # Checks to see if the user already has a cas session.
  # @author David J. Davis
  # @return true
  def authenticated?
    !!(session['cas'] && session['cas']['user'])
  end

  # Find the user that is authenticated by the cas user. 
  # @author David J. Davis
  # @return User Object
  def current_user
    return false unless authenticated?
    User.find_by(cas_username: session['cas']['user'])
  end

  # Checks if the user is an admin?
  # @author David J. Davis
  # @return Boolean
  def admin?
    return false unless authenticated?
    User.exists?(cas_username: session['cas']['user'])
  end

  # Performs a login request to the cas server.
  # @author David J. Davis
  # @return No return value.
  def login
    if authenticated?
      redirect_to root_path, success: I18n.t('auth.success') && return
    else
      render(plain: 'Unauthorized!', status: :unauthorized)
    end
  end

  # Performs a logout request and resets the current session.
  # @author David J. Davis
  # @return No return value.
  def logout
    reset_session
    redirect_to root_path, success: I18n.t('auth.log_out') && return
  end
  alias signout logout
end