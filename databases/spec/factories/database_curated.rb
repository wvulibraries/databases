FactoryBot.define do
  factory :database_curated do
    association :database, factory: :database_basic
    association :subject, factory: :subject
    sort { rand(0...3) }
  end
end
