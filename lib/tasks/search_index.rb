require 'rake'
namespace :search_index do
  desc 'Properly Index Databases in Production'
  task employee: :environment do
    puts "Reindexing Databases"
    Database.import force: true
  end
end