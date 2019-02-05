module ApplicationHelper
  # checks if string is a number
  # @author David J. Davis
  # @return boolean
  def is_number? string
    true if Float(string) rescue false
  end

  # Users IpAddr objects to check IP ranges from subnets 
  # must be set in environment ENV['campus_ip']
  # @param campus_ip (should be an ipAddr object)
  # @author David J. Davis
  # @return boolean
  def campus? client_ip
    ip_range = IPAddr.new(ENV['campus_ip'])
    ip_range.include? client_ip 
  end  
end
