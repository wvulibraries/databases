FactoryBot.define do
  factory :link_tracking do
    ip_address { Faker::Internet.ip_v4_address }

    factory :link_tracking_database_association do
      association :database, factory: :database_default_values
    end    

    factory :seed_testing do
       association :database, factory: :database_basic, status: 1
    end    
  end
end
