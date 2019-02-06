class Public::ConnectController < ApplicationController
  def index 
    # set database
    database = Database.where(url_uuid: params[:uuid]).first
    
    # conditional vars 
    proxy = "#{ENV['proxy_url']}#{database.url}"
    on_campus = campus_ip?(@client_ip) 
    url = on_campus ? database.url : proxy
    
    # core logic 
    if database.campus_only? && !on_campus
      redirect root_path, error: I18n.t('campus_only')
    else
      redirect_to URI.encode(url)
    end 
  end


  # Users IpAddr objects to check IP ranges from subnets 
  # must be set in environment ENV['campus_ip']
  # @param campus_ip (should be an ipAddr object)
  # @author David J. Davis
  # @return boolean
  def campus_ip? client_ip
    ip_range = IPAddr.new(ENV['campus_ip'])
    ip_range.include? client_ip 
  end  
end 