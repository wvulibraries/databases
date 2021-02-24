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
  FactoryBot.create :seed_testing
end

my_user = {
  first_name: 'David',
  last_name: 'Davis',
  cas_username: 'djdavis',  
  cas_email: 'djdavis@mail.wvu.edu'
}

User.create(my_user)

my_user2 = {
  first_name: 'Tracy',
  last_name: 'McCormick',
  cas_username: 'tam0013',  
  cas_email: 'tam0013@mail.wvu.edu'
}

User.create(my_user2)