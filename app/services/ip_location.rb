class IpLocation   
  def initialize(ip)
    @ip = ip 
  end
  def campus_range 
    IPAddr.new(ENV['campus_ip']) 
  end 
  # @return boolean
  def campus? 
    campus_range.include? @ip
  end 
  # @return boolean
  def off_campus? 
    !campus? 
  end 
end