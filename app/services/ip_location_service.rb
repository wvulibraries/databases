# @author(s) David J. Davis, Tracy A. McCormick
# @description service allows us to check if the givin ip on a campus or off campus address.
class IpLocation
  # Users IpAddr objects to check IP ranges from subnets 
  # must be set in environment ENV['campus_ip']    
  # @param [IPAddr<object>] ip    
  def initialize(ip)
    @client_ip = ip 
  end
​
  def campus_range 
    IPAddr.new(ENV['campus_ip']) 
  end 
​
  # @return boolean
  def campus? 
    campus_range.include? @client_ip
  end 
​
  # @return boolean
  def off_campus? 
    !campus? 
  end 
end
