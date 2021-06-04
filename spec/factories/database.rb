FactoryBot.define do
  sequence(:url) { |n| Faker::Internet.url(host: "somethingcool#{n}.com", path: '/index.html') }
  sequence(:url_uuid) { |n| "#{Time.now.to_i}_#{n}" } 
  factory :database do
    factory :database_basic do
      name { "#{Faker::Movies::HitchhikersGuideToTheGalaxy.planet} #{Faker::Educator.course_name}".truncate(150) }
      # database urls
      url
      off_campus_url { Faker::Internet.url }
      url_uuid

      # database info
      status { rand(0..3) } # enumerations are 0-3
      help { Faker::TvShows::GameOfThrones.quote }
      help_url { Faker::Internet.url }
      description { Faker::ChuckNorris.fact }
      title_search { "#{Faker::Movies::HitchhikersGuideToTheGalaxy.planet} #{Faker::Educator.course_name}".truncate(150)  }

      # database booleans
      disable_proxy { Faker::Boolean.boolean }
      new_database { Faker::Boolean.boolean }
      trial_database { Faker::Boolean.boolean }
      popular { Faker::Boolean.boolean }
      alumni { Faker::Boolean.boolean }
      open_access { Faker::Boolean.boolean }

      # dates 
      trial_expiration_date { Faker::Date.between(from: 2.years.ago, to: 1.year.from_now) }
      years_of_coverage { "#{Faker::Date.between(from: 2.years.ago, to: Time.zone.today)} - #{Faker::Date.between(from: 2.days.ago, to: Time.zone.today)}" }
      created_date { Time.zone.today }
      updated_date { Time.zone.today }
    end

    factory :database_default_values do
      name { "#{Faker::Movies::HitchhikersGuideToTheGalaxy.planet} #{Faker::Educator.course_name}".truncate(150) }
      # database urls
      url
      off_campus_url { Faker::Internet.url }

      # database info
      status { rand(0..3) } # enumerations are 0-3
      description { Faker::ChuckNorris.fact }
      title_search { "#{Faker::Movies::HitchhikersGuideToTheGalaxy.planet} #{Faker::Educator.course_name}".truncate(150) }

      # database booleans
      disable_proxy { Faker::Boolean.boolean }
      new_database { Faker::Boolean.boolean }
      trial_database { Faker::Boolean.boolean }
      popular { Faker::Boolean.boolean }
      alumni { Faker::Boolean.boolean }

      # dates 
      trial_expiration_date { Faker::Date.between(from: 2.years.ago, to: 1.year.from_now) }
      years_of_coverage { "#{Faker::Date.between(from: 2.years.ago, to: Time.zone.today)} - #{Faker::Date.between(from: 2.days.ago, to: Time.zone.today)}" }
      created_date { Time.zone.today }
      updated_date { Time.zone.today }
    end
  end
end
