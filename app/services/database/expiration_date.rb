# Expiration Date Service Object.
# @author David J. Davis
class Database::ExpirationDate
  # Initializes and gets the database list for the databases that are new.
  # @author David J. Davis
  # @return empty
  # sets an @trials instance variable from the query. 
  def initialize
    @trails = Database.where(trial_database: true)
  end

  # Checks to see if the current day is greater than the expiration date.
  # @author David J. Davis
  # @return Boolean
  def expired?(expiration_date)
    Date.today.beginning_of_day >= expiration_date.beginning_of_day
  end  

  # Used in the logic to evaluate the trials. 
  # @author David J. Davis
  # @return Database or Boolean
  def set_hidden_expired(database)
    if self.expired?(database.trial_expiration_date)
      database.status = 'hidden' 
      database.save(validate: false)
    end 
    return database
  end 

  # Evaluates the trials as an each statement. 
  # @abstract
  # @author David J. Davis
  # @return nil
  def evaluate_trials 
    @trails.each { |trial_database| self.set_hidden_expired(trial_database) }
  end 
end