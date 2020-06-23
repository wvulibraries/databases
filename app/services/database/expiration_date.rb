class Database::ExpirationDate
  def initialize
    @trails = Database.where(trial_database: true)
  end

  def expired?(expiration_date)
    Date.today.beginning_of_day >= expiration_date.beginning_of_day
  end  

  def set_hidden_expired(database)
    if self.expired?(database.trial_expiration_date)
      database.status = 'hidden' 
      database.save!
    end 
    return database
  end 

  def evaluate_trials 
    @trails.each { |trial_database| self.set_hidden_expired(trial_database) }
  end 
end