FactoryBot.define do
  factory :vendor do
    name { Faker::Lorem.characters(2..50) }
    url { Faker::Internet.url }
  end
end
