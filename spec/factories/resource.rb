FactoryBot.define do
  factory :resource do
    name { Faker::Lorem.characters(2..100) }
  end
end
