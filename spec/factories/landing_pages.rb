FactoryBot.define do
  factory :landing_page do
    instructions { Faker::GameOfThrones.quote }
    contact_name { Faker::GameOfThrones.character }
    contact_email { Faker::Internet.free_email }
    contact_phone_number { "(304) 293-xxxx"  } 
    contact_title { "Science Librarian"}
  end
end
