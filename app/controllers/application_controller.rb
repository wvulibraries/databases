# base application controller
class ApplicationController < ActionController::Base
  # basic application setups 
  protect_from_forgery with: :exception
  add_flash_types :success, :warning, :danger, :info, :error

  # get the ip using a before action
  before_action :client_ip

  # concerns
  include Authenticatable

  # gets the clients ip address and sets as a global
  # @author David J. Davis
  # @return Object IpAddr instance
  def client_ip
    @client_ip ||= IPAddr.new(request.remote_ip)
  end
end
