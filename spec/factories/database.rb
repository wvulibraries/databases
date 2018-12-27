FactoryBot.define do
  sequence(:url) { |n| Faker::Internet.url("somethingcool#{n}.com", '/index.html') }
  sequence(:url_uuid) { |n| "#{Time.now.to_i}_#{n}" } 
  factory :database do
    factory :database_basic do
      name { Faker::HitchhikersGuideToTheGalaxy.planet << Faker::Educator.course_name }
      # database urls
      url
      off_campus_url { Faker::Internet.url }
      url_uuid

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
    end 
  

    factory :database_default_values do
      name { Faker::HitchhikersGuideToTheGalaxy.planet << Faker::Educator.course_name }
      # database urls
      url
      off_campus_url { Faker::Internet.url }

      # database info
      status { rand(0..3) } # enumerations are 0-3
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
    end 
  end 
end
