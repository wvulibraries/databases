# Public::AboutController 
# Controller deals with connecting to the database keeps a "permanent URL". 
class Public::ConnectController < ApplicationController
  # An interesting set of logic taken from the prior version of this app that was in PHP. 
  # @author David J. Davis
  def index
    # set database
    @database = Database.where(url_uuid: params[:uuid]).first
    url = build_url

    # core logic
    if @database.campus_only? && !on_campus
      redirect root_path, error: I18n.t('campus_only')
    else
      redirect_to URI.encode(url)
    end
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
  # @return string
  def build_url
    proxy_url = "#{ENV['proxy_url']}#{@database.url}"
    if campus_ip?(@client_ip)
      @database.url
    else
      proxy_url
    end
  end
end
