FactoryBot.define do
  factory :vendor do
    name { Faker::Lorem.characters(number: rand(2..50)) }
    url { Faker::Internet.url }
  end
end
