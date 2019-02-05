class ConnectionManager
  def initialize(uuid)
      @database = Database.where(url_uuid: uuid)
  end

  # determine on-campus or off-campus 
  def campus?(client_ip)
    
  end 
  # generate a link 
end