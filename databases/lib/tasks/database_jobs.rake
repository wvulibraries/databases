namespace :database_jobs do
  desc "Turning of the new flag"
  task mature: :environment do
    db_mature = Database::Mature.new
    db_mature.evaluate_list
  end

  desc "Looking for trial databases that have been expired"
  task expire: :environment do
    db_expire = Database::ExpirationDate.new
    db_expire.evaluate_trials 
  end
end
