FactoryBot.define do
  factory :database_list do
    name { Faker::HitchhikersGuideToTheGalaxy.planet << Faker::Educator.course_name }
    # database urls
    url { Faker::Internet.url }
    off_campus_url { Faker::Internet.url }
    url_id { Time.now.to_i }

    # database info
    status { rand(0..3) } # enumerations are 0-3
    help { Faker::GameOfThrones.quote }
    help_url { Faker::Internet.url }
    description { Faker::ChuckNorris.fact }
    title_search { Faker::HitchhikersGuideToTheGalaxy.planet << Faker::Educator.course_name }

    # database booleans
    new_database { Faker::Boolean.boolean }
    trial_database { Faker::Boolean.boolean }
    popular { Faker::Boolean.boolean }
    alumni { Faker::Boolean.boolean }

    # dates 
    trial_expire_date { Faker::Date.between(2.years.ago, 1.year.from_now) }
    years_of_coverage { "#{Faker::Date.between(2.years.ago, Date.today)} - #{Faker::Date.between(2.days.ago, Date.today)}" }
    created_date { Date.today }
    updated_date { Date.today }

    # associations
    # vendor { 1 }
    # access { 1 }
    # access_plain_text { 1 }

  end
end
