FactoryBot.define do
  factory :access_plain_text do
    name { Faker::Lorem.characters(2..1000) }
  end
end
