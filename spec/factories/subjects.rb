FactoryBot.define do
  factory :subject do
    name { Faker::Lorem.characters(2..50) }
    url { Faker::Internet.url }
  end
end
