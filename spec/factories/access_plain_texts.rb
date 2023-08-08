FactoryBot.define do
  factory :access_plain_text do
    name { Faker::Lorem.characters(number: rand(2..1000)) }
  end
end
