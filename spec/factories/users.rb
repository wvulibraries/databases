FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    cas_email { "#{Faker::Internet.username(7..36)}@some.thing.edu" }
    cas_username { Faker::Internet.username(7..36) }
  end
end
