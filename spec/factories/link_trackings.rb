FactoryBot.define do
  factory :link_tracking do
    ip_address { Faker::Internet.ip_v4_address }

    factory :link_tracking_database_association do
      association :database, factory: :database_default_values
    end    
  end
end
