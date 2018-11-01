FactoryBot.define do
  factory :database_list do
    name { "MyString" }
    status { 1 }
    years_of_coverage { "MyString" }
    vendor { 1 }
    url { "MyString" }
    off_campus_url { "MyString" }
    updated { "MyString" }
    access_type { 1 }
    full_text_db { 1 }
    new_database { 1 }
    trial_database { 1 }
    access { 1 }
    help { "MyText" }
    help_url { "MyText" }
    description { "MyText" }
    created_date { 1 }
    updated_date { 1 }
    url { nil }
    popular { 1 }
    trial_expire_date { 1 }
    alumni { 1 }
    mobile { false }
    title_search { "MyString" }
  end
end
