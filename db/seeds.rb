# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'factory_bot_rails'

# create some buildings
10.times do
  # Set all generated databases to production status
  FactoryBot.create :database_basic, status: 1
end

10.times do
  # Set all generated databases to production status
  # FactoryBot.create :link_tracking, database: rand(1..10)
  offset = rand(Database.count)
  rand_record = Database.offset(offset).first
  FactoryBot.create :link_tracking, database: rand_record

  #LinkTracking.create(database: @database, ip_address: @client_ip)
end

my_user = {
  first_name: 'Tracy',
  last_name: 'McCormick',
  cas_username: 'tam0013',  
  cas_email: 'tam0013@mail.wvu.edu'
}

User.create(my_user)

my_user = {
  first_name: 'Travis',
  last_name: 'Williamson',
  cas_username: 'twilli23',  
  cas_email: 'twilli23@mail.wvu.edu'
}

User.create(my_user)

my_user = {
  first_name: 'Steven',
  last_name: 'Giessler',
  cas_username: 'sfgiessler',  
  cas_email: 'Steve.Giessler@mail.wvu.edu'
}

User.create(my_user)