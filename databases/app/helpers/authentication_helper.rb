# Authentication helper which combines methods used in controllers and views for authentication.
# @author David J. Davis
module AuthenticationHelper
  # Creates a filter for accessing the admin panel. 
  # Redirects unauthenticated users to the root path.
  # @author David J. Davis
  # @return true
  def access_permissions
    return true if authenticated? && admin?
    redirect_to(root_path, error: access_feedback)
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
end
