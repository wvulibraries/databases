# Public::ConnectController 
# Controller deals with connecting to the database keeps a "permanent URL". 
class Public::ConnectController < ApplicationController
  # An interesting set of logic taken from the prior version of this app that was in PHP. 
  # @author David J. Davis
  # @modified_by Tracy A. McCormick
  def index
    # set database
    @database = Database.where(url_uuid: params[:uuid]).first
    url = build_url

    # core logic
    if @database.campus_only? && !on_campus
      redirect root_path, error: I18n.t('campus_only')
    else
      # save client ip to link tracking for reporting
      save_ip
      # redirect_to URI.encode(url) ? url : URI.encode(url)
      redirect_to url
    end
  end

  # Saves the client_ip for database tracking purposes. 
  # @author Tracy A. McCormick  
  def save_ip 
    link_tracking = LinkTracking.new
    link_tracking.ip_address = @client_ip
    link_tracking.database = @database
    link_tracking.save
  end

  # Users IpAddr objects to check IP ranges from subnets 
  # must be set in environment ENV['campus_ip']
  # @param [IPAddr<object>] client_ip
  # @author David J. Davis
  # @return boolean
  def campus_ip? client_ip
    ip_range = IPAddr.new(ENV['campus_ip'])
    ip_range.include? client_ip
  end

  # This will generate the URL to have a proxy or use the Db URL. 
  # @param <boolean> campus_ip
  # @author David J. Davis
  # @modified_by Tracy A. McCormick
  # @return string
  def build_url
    return @database.url if (campus_ip?(@client_ip) || @database.disable_proxy)
    "#{ENV['proxy_url']}#{@database.url}"
  end
end
