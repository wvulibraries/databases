FactoryBot.define do
  factory :subject do
    name { Faker::Lorem.characters(2..50) }
  end
end
