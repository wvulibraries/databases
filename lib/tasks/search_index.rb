require 'rake'
namespace :search_index do
  desc 'Properly Index Databases in Production'
  task database: :environment do
    puts "Reindexing Databases"
    Database.import force: true
  end
end