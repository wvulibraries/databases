FactoryBot.define do
  factory :landing_page do
    instructions { Faker::TvShows::GameOfThrones.quote }
    contact_name { Faker::TvShows::GameOfThrones.character }
    contact_email { Faker::Internet.email }
    contact_phone_number { "(304) 293-xxxx"  } 
    contact_title { "Science Librarian"}
  end
end
