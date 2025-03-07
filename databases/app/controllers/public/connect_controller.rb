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
      redirect_to url, allow_other_host: true
    end
  end

  # Saves the client_ip for database tracking purposes. 
  # @author Tracy A. McCormick  
  def save_ip 
    LinkTracking.create(database: @database, ip_address: @client_ip)
  end

  # This will generate the URL to have a proxy or use the Db URL. 
  # @param <boolean> campus_ip
  # @author David J. Davis
  # @modified_by Tracy A. McCormick
  # @return string
  def build_url
    return @database.url if (IpLocation.new(@client_ip).campus? || @database.disable_proxy)
    "#{ENV['proxy_url']}#{@database.url}"
  end
end
