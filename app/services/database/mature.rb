# Mature Database Service Object  
# @author David J. Davis
class Database::Mature
  # Initializes and gets the database list for the databases that are new.
  # @author David J. Davis
  # @return empty
  # sets an @new_databases instance variable from the query. 
  def initialize
    @new_databases = Database.new_list
  end

  # Reutrns the newest date from the array
  # @author David J. Davis
  # @return DateTime
  def newest_date(database)
    [database.updated_at, database.created_at].max
  end 

  # Checks to see if the date in the database is six months old
  # @author David J. Davis
  # @return boolean
  def six_months_old?(database)
    date = self.newest_date(database)
    six_month_date = date.beginning_of_day + 6.months
    Date.today.beginning_of_day >= six_month_date
  end 

  # Used in the loop to modify the new database
  # @author David J. Davis
  # @return nil
  def modify_new(database)
    if self.six_months_old?(database)
      database.new_database = false 
      database.save(validate: false)
    end
  end 

  # Triggers an active record save if the validation passes.
  # @abstract 
  # @author David J. Davis
  # @return nil
  def evaluate_list
    @new_databases.each { |database| self.modify_new(database) }
  end 
end