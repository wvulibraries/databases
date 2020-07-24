FactoryBot.define do
  factory :subject do
    name { Faker::Lorem.characters(number: rand(2..50)) }
  end
end
