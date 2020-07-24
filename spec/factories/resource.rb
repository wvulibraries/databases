FactoryBot.define do
  factory :resource do
    name { Faker::Lorem.characters(number: rand(2..100)) }
  end
end
