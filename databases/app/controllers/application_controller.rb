# base application controller
class ApplicationController < ActionController::Base
  # basic application setups 
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info, :error

  # get the ip using a before action
  before_action :client_ip

  # Add this to ApplicationController to debug large session objects
  before_action :check_session_size

  # concerns
  include Authenticatable

  # gets the clients ip address and sets as a global
  # @author David J. Davis
  # @return Object IpAddr instance
  def client_ip
    @client_ip ||= IPAddr.new(request.remote_ip)
  end

  def check_session_size
    if Rails.env.development? && session.to_h.to_s.bytesize > 3500
      Rails.logger.warn "Large session detected: #{session.to_h.to_s.bytesize} bytes"
      Rails.logger.warn "Session keys: #{session.to_h.keys.join(', ')}"
    end
  end
end
