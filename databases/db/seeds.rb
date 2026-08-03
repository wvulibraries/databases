# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'factory_bot_rails'

# --- Subjects (for testing subject associations and deletion) ---
# These names come from production import data and test fixtures.
# We create enough records so IDs reach into the 100+ range (prod has subjects up to ~131).
SUBJECT_NAMES = [
  # Core academic disciplines
  "Biology", "Chemistry", "Physics", "Mathematics", "Computer Science",
  "Engineering", "Psychology", "Education", "Business", "Marketing",
  "Economics", "Political Science", "Sociology", "Philosophy", "History",
  "English Literature", "Art History", "Music", "Theater", "Linguistics",
  # Sciences & health
  "Geosciences", "Animal Science", "Health Sciences", "Medicine",
  "Biomedical Engineering", "Sports Medicine", "Nutrition",
  "Plant and Soil Science", "Wildlife and Fisheries", "Forestry and Natural Resources",
  "Agriculture and Agricultural Economics", "Civil & Environmental Engineering",
  "Mechanical & Aerospace Engineering",
  # Humanities & social sciences
  "Art", "Science", "Criminology", "Criminal Justice",
  "Public Administration", "Social Work", "Communication",
  "Environmental Studies", "Gender Studies", "International Relations",
  # Library / research subjects
  "Literature", "Religion", "Ethics", "Statistics",
  "Materials Science", "Earth Science", "Oceanography",
  "Microbiology", "Ecology", "Genetics",
  # Test subjects (from test fixtures)
  "Test Subject", "Another Test Subject", "SomethingCool"
].uniq

SUBJECT_NAMES.each do |name|
  Subject.find_or_create_by!(name: name) do |s|
    s.url = "https://libraries.wvu.edu/subjects/#{name.parameterize}"
  end
end

puts "Seeded #{Subject.count} subjects."

# --- Link some databases to subjects for realistic test data ---
Database.all.each do |db|
  # Assign 1-4 random subjects to each database
  chosen = Subject.order("RAND()").limit(rand(1..4))
  chosen.each_with_index do |subject, idx|
    DatabaseSubject.find_or_create_by!(database: db, subject: subject) do |ds|
      ds.sort = idx
    end
  end
end

puts "Seeded #{DatabaseSubject.count} database-subject associations."

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
  first_name: 'Jesse',
  last_name: 'Griffis',
  cas_username: 'jagriffis',  
  cas_email: 'jagriffis@mail.wvu.edu'
}

User.create(my_user)

my_user = {
  first_name: 'Steven',
  last_name: 'Giessler',
  cas_username: 'sfgiessler',  
  cas_email: 'Steve.Giessler@mail.wvu.edu'
}

User.create(my_user)

my_user = {
  first_name: 'Jessica',
  last_name: 'McMillen',
  cas_username: 'jmm0177',  
  cas_email: 'jessica.mcmillen@mail.wvu.edu'
}

User.create(my_user)