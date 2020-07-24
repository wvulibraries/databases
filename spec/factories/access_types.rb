FactoryBot.define do
  factory :access_type do
    name { Faker::Lorem.characters(number: rand(2..190)) }
  end
end
