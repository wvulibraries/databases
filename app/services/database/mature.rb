class Database::Mature
  def initialize
    @new_databases = Database.new_list
  end

  def newest_date(database)
    [database.updated_at, database.created_at].max
  end 

  def six_months_old?(database)
    date = self.newest_date(database)
    six_month_date = date.beginning_of_day + 6.months
    Date.today.beginning_of_day >= six_month_date
  end 

  def modify_new(database)
    database.new_database = false if self.six_months_old?(database)
    database.save 
  end 

  def evaluate_list
    @new_databases.each { |database| self.modify_new(database) }
  end 
end