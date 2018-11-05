FactoryBot.define do
  factory :access_type do
    name { Faker::Lorem.characters(2..190) }
  end
end
